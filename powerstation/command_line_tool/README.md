# Powerstation command line tool

* Basically, to get the statistics and anti-patterns detection results:

```$./ana.sh app_name $DIR```

$DIR is the path to your app as application/app/ 

For example, if you want to run a single action,
```
$./single_action.sh forem PostsController,index /home/forem/app/
```

Results will stored in the ../application/forem/results/PostsController_index/*.xml.

* If you wish to run sin actions from an application, do:
```
$./ana.sh app_name /home/forem/app/
```

Results will be saved to the folder under the app directory.
The folder name is defined under global.rb, and by default is /result/.

For you application, we need a calls.txt file, which you can achieve as follows:

* in your app, run:
```
$rake routes | tail -n +2 | awk '{ for (i=1;i<=NF;i++) if (match($i, /.#./)) print $i}' | sed -e 's/#/,/g' | sort | uniq
```
to get the list of entrance controller actions that can be invoked by the app, copy it to APPDIR/calls.txt



