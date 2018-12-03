#!/usr/bin/env bash

usage() { 
  printf "Usage: $0 [options] new_package\n"
  printf "\toptions:\n"
  printf "\t-v\tVerbose\n"
  exit 1 
}

verbose=0

while getopts "h?v" opt; do
    case "$opt" in
    h|\?)
        usage
        exit 0
        ;;
    v)  verbose=1
        ;;
    esac
done

# Getting the name of the new package
index="$((OPTIND))"
target_package="${!index}"
target_class=$(echo $target_package | sed -r 's/(^|_)([a-z]|[0-9])/\U\2/g')

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

printf "${YELLOW}Creating new package: ${target_package}.\n${NC}"
# For any file found in the package
for file in $(find . -type f)
do
  # Get the path and the filename
  dirpath=$(dirname $file)
  filename=$(basename $file)

  # Replace rc_template_cpp in the names of the folders
  # and files
  target_dirpath="${dirpath//rc_template_cpp/$target_package}"
  target_filename="${filename//rc_template_cpp/$target_package}"
  
  printf "Current target file: $file\n"
  # Create folders and copy the files
  # of the new package
  mkdir -p ../$target_package/$target_dirpath
  cp $file ../$target_package/$target_dirpath/$target_filename
  printf "${GREEN}The file has been moved to: ../$target_package/$target_dirpath/$target_filename\n${NC}"
done

printf "${YELLOW}Replacing old recurrences in the new package.\n${NC}"
# Once the package is copied with the names of the files and folders
# changed to the target_package, all the references to rc_template_cpp or
# RCTemplateCpp
for file in $(find ../$target_package -type f)
do
  printf "Current target file: $file\n"
  sed -i -e "s/rc_template_cpp/${target_package}/g" $file
  printf "${GREEN}Recurrences of rc_template_cpp file has replaced to ${target_package} in: $file\n${NC}"
  sed -i -e "s/RCTemplateCpp/${target_class}/g" $file
  printf "${GREEN}Recurrences of RCTemplateCpp file has replaced to ${target_class} in: $file\n${NC}"

done

