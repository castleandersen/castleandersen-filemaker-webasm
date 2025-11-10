#!/bin/zsh

wasm-pack build --target web

TEMPLATE="/tmp/x.js"
WASM_DATA_URL="data:application/wasm;base64,$(base64 -i ./pkg/numbertest_bg.wasm -o - | tr -d '\n')"
echo "WASM size: " $(echo ${WASM_DATA_URL}|wc)
cp ./pkg/numbertest.js ${TEMPLATE}

sed -i '' -e "s|numbertest_bg.wasm|$(printf '%s' "$WASM_DATA_URL" | sed 's/[&/\]/\\&/g')|g" ${TEMPLATE}
TEMPLATE_DATA_URL="data:application/javascript;base64,$(base64 -i ${TEMPLATE} -o - | tr -d '\n')"
echo "TEMPLATE size: " $(echo ${TEMPLATE_DATA_URL}| wc)

cp demo_template.html demo4.html
sed -i '' -e "s|##MODULE##|$(printf '%s' "${TEMPLATE_DATA_URL}" | sed 's/[&/\]/\\&/g')|g" demo4.html
open demo4.html



