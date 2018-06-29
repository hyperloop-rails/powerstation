# Powerstation Static Code Checker

This directory contains the static code checker code that is used by Powerstation.

The static checker can currecntly detect the following API misuse patterns:

1. `exists > 0` => `exists?`
2. `where.first?` => `find_by`
3. `\*` => `\*.except(order)`
4. `each.update` => `update_all`
5. `.count` => `size`
6. `.map` => `.pluck`
7. `pluck.sum` => `sum`
8. `.pluck + pluck` => `SQL UNION`
9. `if exists? find else create end` => `find_or_create_by`

See our [paper](https://hyperloop-rails.github.io/220-HowNotStructure.pdf) for description of these misues.

You can run the checker in two ways:

- as shell script: `string-matching.sh`. You need to first install [pcre](http://pcre.org/) before running.

- as a Java program: the source code is in `regex/src` Example usage: `$java -jar StaticChekcer.jar <folder>`

The results are dumped into `inefficientAPI.xml`.
