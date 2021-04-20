#!/bin/bash

#Script to automate Recon

#When scanning outside tractive network use cookie to gain access
access_cookie="pentest2021=1dcNTwsYkdlI9aCbKcRi34Qs4isjRT;"


# Takes in the flags when executing via cli
while getopts f: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;
    esac
done

echo "Extracting from: $filename";
readarray -t domain_list < $filename

######################################


# collects endpoint through brute and other apis
run_amass(){

	echo " "
	echo "Executing amass...";
	echo " "

	for i in "${domain_list[@]}"
	do
		file_path="outputs/amass/${i}.passive"
		file_path2="outputs/amass/${i}.active"

		amass enum --passive -d $i -o $file_path
		amass enum -src -ip -brute -min-for-recursive 10 -d $i -o $file_path2 -w ~/Documents/SecLists/Discovery/Web-Content/directory-list-2.3-big.txt 
		
	done
}
run_amass

# collects endpoint through crawling
run_gospider(){
	
	echo " "
	echo "Executing gospider...";
	echo " "

	gospider -S $filename -w -o outputs/goSpider -c 2 -d 10 --other-source -H "Accept: */*" --cookie $access_cookie -u "Tractive member Timur"

}
run_gospider



######################################

# Put all data into one file
mesh_files () {
	# get all file name
	declare -a all_files_path
	cd outputs

	for d in */; do
	    cd $d

	    if [[ $(ls | wc -w ) -gt 0 ]]
	    then  
		    ls | xargs cat > "${PWD##*/}_all.txt"
			all_files_path[${#all_files_path[@]}]="${PWD##*/}/${PWD##*/}_all.txt"
			echo "${PWD##*/}/${PWD##*/}_all.txt"
	    fi

	    cd ..
	done

	echo "${all_files_path[*]}" | xargs cat > all.txt
	cat all.txt | grep '.js' > onlyJS/all_js.txt
	cd ..

}
mesh_files

######################################


# Removes invalid and duplicates
filter () {
	cd outputs 

	cat all.txt | httprobe > probed.txt

	cd outputs & cat all.txt | ~/tools/urldedupe/urldedupe > filter.txt

	cd ..
}
filter



