#!/bin/bash

# any? => exists?

grep -r '\.any?' *

# where.first? => find_by

grep -r '\.where(.*)\.first' *

# => *.except(order)

# each.update => update_all
# .count => size
# .map => .pluck
# pluck.sum => sum
# .pluck + pluck => SQL UNION
# if exists? find else create end => find_or_create_by 