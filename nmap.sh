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

	for i in "${domain_list[@]}"
	do
		target=$i
	
		if [[ ! $target =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] 
			then
				target= dig +short $target				
		fi
		
		nmap -sV -sT -sU -p- -Pn $target -o "nmap/${target}.txt"
	done
}
run_nmap