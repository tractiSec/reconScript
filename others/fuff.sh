run_fuff(){

	echo " "
	echo "Executing fuff...";
	echo " "

	for i in "${domain_list[@]}"
	do
		
		ffuf -c -w ~/Documents/SecLists/Discovery/Web-Content/directory-list-2.3-big.txt -u $i -H "User-Agent: Tractive member Timur" -o outputs/fuff
	done
}
run_fuff
