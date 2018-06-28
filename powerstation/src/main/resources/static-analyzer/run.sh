apps=(lobsters redmine diaspora falling-fruit gitlab onebody  spree discourse fulcrum openstreetmap ror tracks)
for i in "${apps[@]}"
do 
 rm -rf applications/pw-$i
 ./analyze.sh pw-$i /Users/jwy/Research/apps/$i/    
done
