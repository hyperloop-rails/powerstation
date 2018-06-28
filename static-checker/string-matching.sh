#!/bin/bash

# any? => exists?

grep -r '\.count > 0?' *

# where.first? => find_by

grep -r '\.where(.*)\.first' *

# => *.except(order)

grep -r '\.group(.*)\.count' *

# each.update => update_all
pcregrep -M  'each.*(\n|.)*update' * 

# .count => size

grep -r '\.count' *

# .map => .pluck

grep -r '\.map' *

# pluck.sum => sum

grep -r '\.pluck(.*)\.sum' *
# .pluck + pluck => SQL UNION

grep -r '\.pluck(.*).*+.*\.pluck(.*)' *

# if exists? find else create end => find_or_create_by 

pcregrep -M  'if.*exists?.*(\n|.)*find.*(\n|.)*else.*(\n|.)*create.*(\n|.)*end' * 
