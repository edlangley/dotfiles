#!/bin/sh

#set -x

TAGS_DB_DIR="/home/elangley/not_backed_up/tags_cscope_databases"

# Build a search pattern for grep to find source files of interest
FILE_EXT_GREPSTR=""
EXTS_TO_TAG_FILE=$TAGS_DB_DIR/file_extensions_to_tag.txt

if [ ! -e  ]; then
    echo "$0: The required setup file $EXTS_TO_TAG_FILE not found"
    exit
fi

for FILE_EXT in `cat $EXTS_TO_TAG_FILE`; do
    if [ "$FILE_EXT_GREPSTR" != "" ]; then
        FILE_EXT_GREPSTR="$FILE_EXT_GREPSTR\|"
    fi
    FILE_EXT_GREPSTR="$FILE_EXT_GREPSTR\.$FILE_EXT$"
done

# Find all the existing cscope source file lists and update them
for CSCOPE_LIST_FILE in `find $TAGS_DB_DIR -name cscope.files`; do
    TAGS_DIR_FULLPATH=$(dirname $(realpath $CSCOPE_LIST_FILE))

    echo "Re-generating $TAGS_DIR_FULLPATH/cscope.files"

    SRC_DIR_FULLPATH=$(realpath $TAGS_DIR_FULLPATH/src_dir_link/)
    find $SRC_DIR_FULLPATH | grep "$FILE_EXT_GREPSTR" > $TAGS_DIR_FULLPATH/cscope.files

    # Then rebuild the tags
    cd $TAGS_DIR_FULLPATH
    echo "Re-generating $TAGS_DIR_FULLPATH/cscope.out"
    cscope -b

    echo "Re-generating $TAGS_DIR_FULLPATH/tags"
    ctags -L cscope.files

done




