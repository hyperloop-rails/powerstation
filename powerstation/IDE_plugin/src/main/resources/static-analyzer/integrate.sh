file=("loop_invariant.xml" "dead_store.xml" "inefficient_render.xml" "common_subexpression.xml" "redundant_usage.xml")
start=("loopInvariants" "dead_store_queries" "inefficientRenders" "commonSubexprs" "redundantData")
app="$1/results/"
echo $app
index=0
for i in "${file[@]}"
do
   : 
   fn="$app/*/$i"
   re="$app/$i"
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
