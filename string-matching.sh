#!/bin/bash

# any? => exists?

grep -r '\.any?' *

# where.first? => find_by

grep -r '\.where(.*)\.first' *

# => *.except(order)

# each.update => update_all

# .count => size

grep -r '\.count' *

# .map => .pluck

grep -r '\.map' *

# pluck.sum => sum

grep -r '\.pluck(.*)\.sum' *
# .pluck + pluck => SQL UNION

grep -r '\.pluck(.*).*+.*\.pluck(.*)' *

# if exists? find else create end => find_or_create_by 

pcrep 