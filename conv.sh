#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# Create tree.dot derivatives
sed -e "1r comp/nodecomp" -e "\$e cat comp/comp" tree.dot > ./temp/comp.dot
sed -e "1r comp/noderetire" -e "\$e cat comp/retire" tree.dot > ./temp/retire.dot

# Generate svg images
dot tree.dot -Tsvg > temp/tree.svg
# dot res/legend.dot -Tsvg > res/legend.svg
dot temp/comp.dot -Tsvg > temp/comp.svg
dot temp/retire.dot -Tsvg > temp/retire.svg

# Make icons inline, combine images
python utils.py

convert -density 216 -background none temp/lorax.svg -tile res/maptile.jpg -draw "color 0,0 reset" temp/lorax.svg -flatten lorax.png
# dot dot -Tsvg > tree.svg && convert tree.svg legend.svg res.svg
# sed -e "1r comp/node" -e "\$e cat comp/comp" dot > partydot && dot partydot -Tsvg > partyicons.svg && convert -background none partyicons.svg tree.svg legend.svg -flatten party.svg
