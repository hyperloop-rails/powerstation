# Using the Powerstation command line tool

To get the statistics and performance bug detection results, run:

```$./ana.sh app_name $DIR```

where `$DIR` is the path to your applications `app` directory.

For example, if you want to get the results for a single action called `PostsController` in the `foo` application, then run:
```
$./single_action.sh forem PostsController,index /home/foo/app/
```

Results will be stored in `../application/foo/results/PostsController_index/*.xml`.

If you want to get the results from all actions in `foo`, then run:
```
$./ana.sh foo /home/foo/app/
```

Results will be saved to the folder under the `app` directory.
The folder name is defined in `global.rb`, which by default is `/result/`.

The tool needs to know all entrance controller actions from your application. It assumes them to be stored in a file called `calls.txt`. You can generate that file by running:

```
$rake routes | tail -n +2 | awk '{ for (i=1;i<=NF;i++) if (match($i, /.#./)) print $i}' | sed -e 's/#/,/g' | sort | uniq
```
in your app, and then copying it to `<APPDIR>/calls.txt`.
