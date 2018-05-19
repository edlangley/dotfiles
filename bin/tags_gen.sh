#!/bin/sh

TAGS_DB_DIR="/home/elangley/not_backed_up/tags_cscope_databases"

# Check args
if [ $# -ne 1 ]; then
    echo "Usage:\n  $0 <src_dir>"
    exit
fi

if [ ! -d $1 ]; then
    echo "$0: Can't process '$1': No such directory"
    exit
fi

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

#echo "Debug: grep string is: $FILE_EXT_GREPSTR"
#exit

# Create the list of source files
SRC_DIR_FULLPATH=$(realpath $1)
SRC_DIR_BASENAME=$(basename $SRC_DIR_FULLPATH)

echo "Generate source tags+cscope DB for $SRC_DIR_FULLPATH -> $TAGS_DB_DIR/$SRC_DIR_BASENAME"

if [ ! -d $TAGS_DB_DIR/$SRC_DIR_BASENAME ]; then
    echo "Creating dir $TAGS_DB_DIR/$SRC_DIR_BASENAME"
    mkdir -p $TAGS_DB_DIR/$SRC_DIR_BASENAME
fi

echo "Creating $TAGS_DB_DIR/$SRC_DIR_BASENAME/cscope.files"
find $SRC_DIR_FULLPATH | grep "$FILE_EXT_GREPSTR" > $TAGS_DB_DIR/$SRC_DIR_BASENAME/cscope.files
cd $TAGS_DB_DIR/$SRC_DIR_BASENAME

# Create the tags
echo "Creating $TAGS_DB_DIR/$SRC_DIR_BASENAME/cscope.out"
cscope -b

echo "Creating $TAGS_DB_DIR/$SRC_DIR_BASENAME/tags"
ctags -L cscope.files

echo "Creating $TAGS_DB_DIR/$SRC_DIR_BASENAME/src_dir_link"
ln -s $SRC_DIR_FULLPATH src_dir_link

