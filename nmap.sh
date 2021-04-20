#!/bin/bash


# Takes in the flags when executing via cli
while getopts f: flag
do
    case "${flag}" in
        f) filename=${OPTARG};;
    esac
done

echo "Extracting from: $filename";
readarray -t domain_list < $filename


# scans ports
run_nmap(){

	echo " "
	echo "Executing nmap...";
	echo " "
	ip_regex="^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$"

	for i in "${domain_list[@]}"
	do
		target=domain_list[$i]

		if ! [[$target =~ $ip_regex]]; 
			then
				target=dig +short $target
		fi
		
		nmap -sV -sT -sU -p- -Pn $target -o "nmap/${target}.txt"
	done
}
run_nmap