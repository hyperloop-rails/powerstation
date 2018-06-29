app=$1
c_a=$2
input=$3
output='./applications/'
pre_pro='./preprocess_views'
controller='./controller_model_analysis'
call=$input/'calls.txt'
schema=$input/db/'schema.rb'
rm -rf $output/$app
echo "remove existing"
mkdir $output/$app
echo "move app dir to applications "
cp -r $input/app/* $output/$app/
cp $call $output/$app
cp $schema $output/$app
echo "finished moving"

echo "preprocessing"
echo $app
cd $pre_pro; pwd; chmod +x check_system.sh;./check_system.sh; ruby main.rb -a $app; cd ../
echo "finish preprocessing"

echo "jruby get dataflow"
cd $output; pwd; ruby generate_dataflow_log.rb $app $c_a;  cd ../
echo "FINISH dataflow"

echo "run analysis"
cd $controller; pwd; ruby main.rb -s $c_a -d ../$output/$app/ 
echo "FINISH analysis"
cd ../
file=("loop_invariant.xml" "dead_store.xml" "inefficient_render.xml" "common_subexpression.xml" "redundant_usage.xml")
start=("loopInvariants" "dead_store_queries" "inefficientRenders" "commonSubexprs" "redundantData")
result="$output/$app/results"
ca=`echo $c_a | sed -e "s/,/_/g"`
echo $result
index=0
for i in "${file[@]}"
do
   :
   fn="$result/$ca/$i"
   re="$result/$i"
   echo $i
   s=${start[$index]}
   index=$index+1
   #echo $s
   #echo $fn
   echo "<$s>" > $re
   cat $fn >> $re
   echo "</$s>" >> $re
   # do whatever on $i
done
