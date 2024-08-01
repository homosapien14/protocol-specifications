#!/bin/bash
set -e

FILES=("./api/meta/build/meta.yaml" "./api/registry/build/registry.yaml" "./api/transaction/build/transaction.yaml")

for FILE in "${FILES[@]}"; do
    if [ -f "$FILE" ]; then
        echo "Linting $FILE..."
        OUTPUT=$(openapi lint "$FILE" 2>&1)
        if [ $? -ne 0 ]; then
            echo "$OUTPUT"
            ERRORS=1
        else
            echo "$FILE is valid"
        fi
    else
        echo "$FILE does not exist"
        ERRORS=1
    fi
done

if [ $ERRORS -ne 0 ]; then
    echo "There were linting errors. Please fix them before merging."
    exit 1
fi

