#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# Create tree.dot derivatives
sed -e "1r comp/nodecomp" -e "\$e cat comp/comp" tree.dot > comp.dot
sed -e "1r comp/noderetire" -e "\$e cat comp/retire" tree.dot > retire.dot

# Generate svg images
dot tree.dot -Tsvg > tree.svg
dot legend.dot -Tsvg > legend.svg
dot comp.dot -Tsvg > comp.svg
dot retire.dot -Tsvg > retire.svg

# Make icons inline, combine images
python utils.py

convert -density 216 -background none lorax.svg -tile maptile.jpg -draw "color 0,0 reset" lorax.svg -flatten lorax.png
# dot dot -Tsvg > tree.svg && convert tree.svg legend.svg res.svg
# sed -e "1r comp/node" -e "\$e cat comp/comp" dot > partydot && dot partydot -Tsvg > partyicons.svg && convert -background none partyicons.svg tree.svg legend.svg -flatten party.svg
