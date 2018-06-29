# static-checker

this static-checker is used to detect the simple API misuse patterns:
1. exists > 0 => exists?
2. where.first? => find_by
3. \* => \*.except(order)
4. each.update => update_all
5. .count => size
6. .map => .pluck
7. pluck.sum => sum
8. .pluck + pluck => SQL UNION
9. if exists? find else create end => find_or_create_by

## shell version 
```$./string-matching.sh```

Environment requirement:

Install [pcre](http://pcre.org/).

## java version

source code is under the regex/src folder

usage: 
```$java -jar StaticChekcer.jar folder```

The result is dumped into "inefficientAPI.xml"



