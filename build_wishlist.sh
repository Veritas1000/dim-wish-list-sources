#!/usr/bin/env bash

BUILT_WISHLIST_FILE="built_wishlist.txt"
BUILT_WISHLIST_TITLE="A compiled wishlist generated from sublists"

MKB=true
CONTROLLER=false
INCLUDE_TRASH=true

add_sublist() {
    echo "Adding $1"

    cat $1 >> $BUILT_WISHLIST_FILE
    echo "" >> $BUILT_WISHLIST_FILE
}

echo "Combining sublists into ${BUILT_WISHLIST_FILE}:"

echo "title: ${BUILT_WISHLIST_TITLE}" > $BUILT_WISHLIST_FILE
echo "" >> $BUILT_WISHLIST_FILE

# Veritas1000's lists
for sublist in "$(ls -1 Veritas1000/*.txt | sort -r)";do
    add_sublist "$sublist"
done

#Panda's lists
for sublist in PandaPaxxy/*.txt;do
    if [[ $sublist == *"controller"* && "$CONTROLLER" = false ]] \
        || [[ $sublist == *"mkb"* && "$MKB" = false ]]
    then
        echo "-- SKIPPING $sublist"
    else
        add_sublist $sublist
    fi
done

# Mercules904's lists
for sublist in Mercules904/*.txt;do
    add_sublist $sublist
done

# AyyItsChevy's lists
for sublist in AyyItsChevy/*.txt;do
    add_sublist $sublist
done

if [ "$INCLUDE_TRASH" = true ];then
    for sublist in "$(ls -1 */*trash*.txt | sort -r)";do
        add_sublist "$sublist"
    done
fi