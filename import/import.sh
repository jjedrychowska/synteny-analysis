#!/bin/bash

mkdir -p csv

USER=placeholder
export MYSQL_PWD=placeholder
export MYSQL_HOST=placeholder

mysql -u $USER -D danio_rerio_core_98_11 < query.sql | sed -E "s/$(printf '\t')/\";\"/g; s/^/\"/; s/$/\"/" > csv/danio_rerio_core_98_11.csv
mysql -u $USER -D homo_sapiens_core_98_38 < query.sql | sed -E "s/$(printf '\t')/\";\"/g; s/^/\"/; s/$/\"/" > csv/homo_sapiens_core_98_38.csv
mysql -u $USER -D lepisosteus_oculatus_core_98_1 < query.sql | sed -E "s/$(printf '\t')/\";\"/g; s/^/\"/; s/$/\"/" > csv/lepisosteus_oculatus_core_98_1.csv
