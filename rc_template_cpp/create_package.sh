#!/usr/bin/env bash

# TODO: move usage functio to other file
usage() { 
  printf "Usage: $0 [options] new_package\n"
  printf "\toptions:\n"
  printf "\t-v\tVerbose.\n"
  echo
  printf "\t-P\tUncomment publisher in the result package.\n"
  echo
  printf "\t-S\tUncomment subscriber in the result package.\n"
  echo
  printf "\t-s\tUncomment service server in the result package.\n"
  printf "\t\tThis option can be combined with other options:\n"
  printf "\t\t-c: to uncomment the service client and the server.\n"
  printf "\t\t-C: to uncomment only the service client.\n"
  echo
  printf "\t-a\tUncomment action server in the result package.\n"
  printf "\t\tThis option can be combined with other options:\n"
  printf "\t\t-c: to uncomment the action client and the server.\n"
  printf "\t\t-C: to uncomment only the action client.\n"
  echo
  printf "\t-c\tUncomment the clients in adition to the servers selected in the result package.\n"
  printf "\t\tThis option HAS to be combined with other options:\n"
  printf "\t\t-a: to uncomment the action client and the server.\n"
  printf "\t\t-s: to uncomment the service client and the server.\n"
  echo
  printf "\t-c\tUncomment only clients in the result package.\n"
  printf "\t\tThis option HAS to be combined with other options:\n"
  printf "\t\t-a: to uncomment only the action client.\n"
  printf "\t\t-s: to uncomment only the service client.\n"
  echo
  printf "\t-A\tUncomment all (pub, sub, clients and servers).\n"
  exit 1 
}

verbose=0

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

while getopts "h?vPSsacCA" opt; do
    case "$opt" in
    h|\?)
        usage
        exit 0
        ;;

    v)  verbose=1
        ;;

    P)  publisher=true
        ;;

    S)  subscriber=true;
        ;;
    
    s)  service_s=true;
        ;;

    a)  action_s=true;
        ;;

    c)  
        if [ ! $service_s ] && [ ! $action_s ]
        then
          printf "${RED}-c option has to be used with -a or -s option${NC}\n"
          usage
          exit 0
        fi

        if [ $service_s ]
        then
          service_c=true
        fi

        if [ $action_s ]
        then
          action_c=true
        fi
        ;;

    C)  
        if [ ! $service_s ] && [ ! $action_s ]
        then
          printf "${RED}-C option has to be used with -a or -s option${NC}\n"
          usage
          exit 0
        fi

        if [ $service_s ]
        then
          service_s=false
          service_c=true
        fi

        if [ $action_s ]
        then
          action_s=false
          action_c=true
        fi
        ;;

    A)  publisher=true
        subscriber=true
        action_c=true
        action_s=true
        service_c=true
        service_s=true
        ;;
    esac
done

# Getting the name of the new package
index="$((OPTIND))"
target_package="${!index}"

if [ "$target_package" == "" ]
then
  printf "${RED}The name of the new_package was not declared.${NC}\n"
  usage
  exit 0
fi

target_class=$(echo $target_package | sed -r 's/(^|_)([a-z]|[0-9])/\U\2/g')

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

