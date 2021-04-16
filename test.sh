
# get all file name
declare -a all_files_path
cd outputs
for d in */; do
    #echo "$d"
    cd $d
    if [[ $(ls | wc -w ) -gt 0 ]]
    then
	    dir_name="${PWD##*/}_all.txt"
	    #echo $dir_name
	    ls | xargs cat > "${PWD##*/}_all.txt"
	    #curr_dir=
		
		all_files_path[${#all_files_path[@]}]="${PWD##*/}/${PWD##*/}_all.txt"
		echo "${PWD##*/}/${PWD##*/}_all.txt"
    fi

    cd ..
done

echo "${all_files_path[*]}" | xargs cat > all.txt
cd ..