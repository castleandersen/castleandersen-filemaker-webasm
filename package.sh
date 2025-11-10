#!/bin/zsh

OUTPUT_FILE=demo.html
DEMO_TEMPLATE_FILE=demo_template.html
TEMPLATE=`mktemp /tmp/numbertest.XXXXX`

echo "Building WASM module with wasm-pack."

wasm-pack build --target web

if [ $? -ne 0 ]; then
    echo "wasm-pack build failed. Exiting."
    exit 1
fi

echo "Packaging WASM module and JS glue code into single HTML file for FileMaker demo."

WASM_DATA_URL="data:application/wasm;base64,$(base64 -i ./pkg/numbertest_bg.wasm -o - | tr -d '\n')"
echo "WASM size: " $(echo ${WASM_DATA_URL}|wc -c)

cp ./pkg/numbertest.js ${TEMPLATE}
sed -i '' -e "s|numbertest_bg.wasm|$(printf '%s' "$WASM_DATA_URL" | sed 's/[&/\]/\\&/g')|g" ${TEMPLATE}

TEMPLATE_DATA_URL="data:application/javascript;base64,$(base64 -i ${TEMPLATE} -o - | tr -d '\n')"
echo "Template size: " $(echo ${TEMPLATE_DATA_URL}| wc -c)

cp ${DEMO_TEMPLATE_FILE} ${OUTPUT_FILE} 
sed -i '' -e "s|##MODULE##|$(printf '%s' "${TEMPLATE_DATA_URL}" | sed 's/[&/\]/\\&/g')|g" ${OUTPUT_FILE}

echo "Copying ${OUTPUT_FILE} to clipboard so you can paste it in to FileMaker source field."
cat ${OUTPUT_FILE} | pbcopy

echo "Opening ${OUTPUT_FILE} in default browser for testing outside FileMaker."
open ${OUTPUT_FILE}



