# I only have to do this because tauri is incredibly annoying with FS scopes D:

# Get the file path from the second argument
FILE_PATH=$(basename "$1")
APPDATA_PATH=$(basename "$2")
BASE_SCRIPT_PATH=$(basename "$0")
echo "$APPDATA_PATH/tmp/$FILE_PATH" 
if (( $# < 3 )); then
    echo "Usage: $basename $0 <file path> <appdata path>"
    exit 1
fi

# Copy the file to the appdata directory

# cp $FILE_PATH "$APPDATA_PATH/tmp/$FILE_PATH"