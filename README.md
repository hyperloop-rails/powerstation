# PowerStation

### What for :

Find performance issues for 6 anti-patterns:

1. Loop invariant queries

2. Dead store queries

3. Unused data-retrieval queries

4. Common sub-expression queries

5. API misuses

6. Inefficient data rendering

Specifically, you for 5. API misuses, you can also refer to the simple static checker.


### RubyMine Plugin Version

#### How to compile

Open it in Intellij IDEA

Choose `gradle` to run a new task as: `runIDE`

Run it.

Find your PowerStation under `build/lib/powerstation.jar`

#### How to use the plugin

[Tutorial](https://hyperloop-rails.github.io/powerstation/)

## #Static analysis CMD line Version

Under the `src/main/resources/static-analyzer` folder 

# static-checker
this static-checker is used to detect the simple API misuse patterns in our table 7
1. count > 0 => exists?
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
