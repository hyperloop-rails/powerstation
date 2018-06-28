# PowerStation

## Compile it on your own computer

Open it in Intellij IDEA

Choose `gradle` to run a new task as: `runIDE`

Run it.

Find your PowerStation under `build/lib/powerstation.jar`

## How to use the plugin

[Tutorial](https://hyperloop-rails.github.io/powerstation/)

## Static analysis code

Under the `src/main/resources/static-analyzer` folder 

# static-checker
this static-checker is used to detect the simple API misuse patterns in our table 7
1. exists > 0 => exists?
2. where.first? => find_by
3. * => *.except(order)
4. each.update => update_all
5. .count => size
6. .map => .pluck
7. pluck.sum => sum
8. .pluck + pluck => SQL UNION
9. if exists? find else create end => find_or_create_by

Environment requirement
for multiline regex expression matching, need to install pcre
link: http://pcre.org/
