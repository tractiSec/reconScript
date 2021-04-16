#!/bin/bash

#Script to automate Recon

#When scanning outside tractive network use cookie to gain access
access_cookie="pentest2021=1dcNTwsYkdlI9aCbKcRi34Qs4isjRT;"

while getopts m:f: flag
do
    case "${flag}" in
        m) manual=${OPTARG};;
        f) filename=${OPTARG};;
    esac
done
#echo "Manual: $manual";
echo "Extracting from: $filename";

######################################

run (){
	readarray -t domain_list < $filename

	echo "Executing amass...";
	for i in "${domain_list[@]}"
	do
		file_path="outputs/amass/${i}.passive"
		file_path2="outputs/amass/${i}.active"

		# amass
		amass enum --passive -d $i -o file_path
		amass enum  -src -ip -brute -min-for-recursive 10 -d $i -o file_path2

		# gospider
		gospider -s $i -o goSpider -c 2 -d 10 -H "Accept: */*" --cookie $access_cookie -u "Tractive member Timur"

		#waybackurls
		cat $i | waybackurls > "outputs/waybackurls/${1}"

		
	done
}
#run

# Put all input into one file
mesh_files () {
	# get all file name
	declare -a all_files_path
	for dir in outputs
		do
		  cd $dir
		  echo $dir
		  ls | xargs cat > "${dir}_all".txt
		  curr_dir='pwd'
		  all_files_path[${#all_files_path[@]}]="${curr_dir}/${dir}_all".txt
		done
  
    cat echo "${all_files_path[*]}" > outputs/all.txt
}
mesh_files

#LinkFinder
#feed only js files
#python3 ~/tools/LinkFinder/linkfinder.py -i https://example.com/1.js -o "outputs/linkfinder/${1}.html" -c access_cookie





# TODO

## congregate all urls
## extract js files from list
## create individual loop for each tool
## Clean command - removes all created files


# PRE REQUISITES
#
# GO
# amass
# download a config file from github & Get/insert API keys for amass 
# gospider
# waybackurls
# LinkFinder 
