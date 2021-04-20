#############################################
# Reconnaissance Script v1
#############################################


This is directory is for use of the recon.sh and nmap.sh script which runs some tools for reconnaissance for doing pen testing. The recon.sh will collect as many endpoints as possible going back all the way to creation of the domain. One will have huge list of domains most will be invalid, through probing we will filter invalid and duplicates. In the end we should have a list of valid endpoints. The nmap will run port scans.  
To run the script type the following to the cli:

  > bash script.sh {filename of hostname}

  or

  > bash nmap.sh {filename of hostname/ip's}

The following tools are pre-requisites to running the script

# GO
# amass
# gospider
# httprobe
# urldedupe

more information about the tools can be found here: https://wiki.tractive.com/display/TEC/Methodology.

The directory structure is hardcoded so avoid moving/renaming/deleting directories. 

