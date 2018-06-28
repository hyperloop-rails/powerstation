#!/bin/bash

#applications="boxroom lobsters communityengine publify jobsworth amahiPlatform railscollab sharetribe onebody linuxfr rucksack sugar kandan fulcrum tracks browsercms"
#applications="lobsters amahiPlatform fulcrum linuxfr onebody rucksack sugar boxroom jobsworth publify railscollab sharetribe tracks brevidy communityengine"

applications="sugar amahiPlatform lobsters wallgig boxroom enki kandan kanban discourse diaspora publify railscollab onebody gitlab jobsworth rucksack sharetribe communityengine linuxfr calagator forem fulcrum tracks brevidy shoppe redmine"
#applications="gitlab discourse shoppe sharetribe kandan lobsters communityengine"
#applications="sugar amahiPlatform lobsters wallgig boxroom enki kandan kanban publify railscollab diaspora tracks rucksack communityengine linuxfr calagator forem fulcrum brevidy shoppe"

export PATH=$PATH:~/jruby/bin

function run_single_app () {
	app=$1
	echo "start app ${app}"
	#cd ~/workspace/ORM_analysis/applications/${app}/

	#rm -rf dataflow
	#cd ~/ruby_source/ORM_analysis/applications/
	#python generate_dataflow.py ${app} >> logs/${app}_log.log
	
	#rm -rf results
	#mkdir results
	#cd ~/ruby_source/ORM_analysis/controller_model_analysis
	ruby main.rb -a -d ../applications/${app}/ > ${app}.log
  echo "Finish app ${app}"
}



for app in $applications ; do
	run_single_app "${app}" &
done
