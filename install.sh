#!/bin/bash

#### Colors Output

RESET="\033[0m"			# Normal Colour
RED="\033[0;31m" 		# Error / Issues
GREEN="\033[0;32m"		# Successful       
BOLD="\033[01;01m"    	# Highlight
WHITE="\033[1;37m"		# BOLD
YELLOW="\033[1;33m"		# Warning
PADDING="  "
DPADDING="\t\t"


#### Other Colors / Status Code

LGRAY="\033[0;37m"		# Light Gray
LRED="\033[1;31m"		# Light Red
LGREEN="\033[1;32m"		# Light GREEN
LBLUE="\033[1;34m"		# Light Blue
LPURPLE="\033[1;35m"	# Light Purple
LCYAN="\033[1;36m"		# Light Cyan
SORANGE="\033[0;33m"	# Standar Orange
SBLUE="\033[0;34m"		# Standar Blue
SPURPLE="\033[0;35m"	# Standar Purple      
SCYAN="\033[0;36m"		# Standar Cyan
DGRAY="\033[1;30m"		# Dark Gray
TIME=$(date +'%H:%M:%S')

banner() {
    clear
    echo -e "
${LBLUE}                                         //////                              ${RESET}   
${LBLUE}                                         //////                              ${RESET}    
${LBLUE}                                         //////                              ${RESET}    
${LBLUE}                          ////// /////// //////                              ${RESET}    
${LBLUE}                          ////// *////// //////             ///              ${RESET}    
${LBLUE}                          ////// .////// //////            //////            ${RESET}    
${LBLUE}                  /////// ////// /////// ////// ///////    ///////           ${RESET}    
${LBLUE}                  ,////// ////// /////// ////// ///////    ///////////////   ${RESET}    
${LBLUE}                                                           //////////////    ${RESET}    
${LBLUE}             ////////////////////////////////////////////////////////,       ${RESET}    
${LBLUE}             ///////////////////////////////////////////////////             ${RESET}    
${LBLUE}              /////////////////////////////////////////////////              ${RESET}    
${LBLUE}              ////////////////////////////////////////////////               ${RESET}    
${LBLUE}               /////////////////////////////////////////////                 ${RESET}    
${LBLUE}                //////////////////////////////////////////                   ${RESET}    
${LBLUE}                 //////////////////////////////////////                      ${RESET}    
${LBLUE}                    ///////////////////////////////*                         ${RESET}    
${LBLUE}                        /////////////////////                                ${RESET}    "
    echo -e "
    
${GREEN}███╗   ███╗ █████╗ ███████╗${SORANGE}   ${SPURPLE}██╗  ██╗${RESET}
${GREEN}████╗ ████║██╔══██╗██╔════╝${SORANGE}   ${SPURPLE}╚██╗██╔╝${RESET}
${GREEN}██╔████╔██║███████║█████╗${SORANGE}█████╗${SPURPLE}╚███╔╝ ${RESET}
${GREEN}██║╚██╔╝██║██╔══██║██╔══╝${SORANGE}╚════╝${SPURPLE}██╔██╗ ${RESET}
${GREEN}██║ ╚═╝ ██║██║  ██║███████╗${SORANGE}   ${SPURPLE}██╔╝ ██╗${RESET}
${GREEN}╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝${SORANGE}   ${SPURPLE}╚═╝  ╚═╝${RESET} ${LCYAN}{v1.0#} ${SBLUE}created by ${SORANGE}@Sianturi1337${RESET}

${SPURPLE}Mae-X${RESET} - ${SCYAN}Docker${RESET} Auto Install\n\n"

echo -e "${SBLUE}Labs : https://labs.tintonarya.com${RESET} | ${YELLOW}My Home : https://tintonarya.com${RESET} | ${LCYAN}GitHub : https://github.com/Sianturi1337${RESET}"
echo -e ""

}



checkPrivileges(){

    echo "[*] Start at $(date)"
    echo -e "[${LBLUE}${TIME}${RESET}] [${YELLOW}WARNING${RESET}] Make sure you install the ${GREEN}Docker${RESET} on a clean server${reset}"

    if [ "$EUID" -ne 0 ]; then
        echo -e "[${LBLUE}${TIME}${RESET}] [${RED}ERROR${RESET}] ${RED}✘${RESET} Oops! You must run this tools using root/superuser privileges."
    exit
    fi

}

checkOS_package() {

    echo -e "[${LBLUE}${TIME}${RESET}] [${GREEN}INFO${RESET}] Checking OS for Compability"
    if [[ ${OSTYPE} == "linux-gnu" ]]; then
        if [[ "$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2 | awk '{print $1;}')" =~ ^(Ubuntu|Debian)$ ]]; then
            if command -v docker &> /dev/null; then
                echo -e "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] ${GREEN}Docker${RESET} is already installed"
            else
                echo -e "[${LBLUE}${TIME}${RESET}] [${RED}ERROR${RESET}] ${RED}Docker${RESET} is not installed ${RED}✘${RESET}, trying to install..."
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Updating OS ------->> "
                `sudo apt -qq -y update &> /dev/null` #Updating repository with silent options
                wait
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Installing cURL ------->> "
                `sudo apt -qq -y install curl &> /dev/null`
                wait
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Installing HTTPS Download Transport for APT ------->> "
                `sudo apt -qq -y install curl apt-transport-https &> /dev/null`
                wait
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Installing Certificate Authority ------->> "
                `sudo apt -qq -y install curl ca-certificates &> /dev/null`
                wait
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Installing Software Properties Common ------->> "
                `sudo apt -qq -y install software-properties-common &> /dev/null`
                wait
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"                                            
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Adding GPG Keys ------->> "
                `sudo mkdir -p /etc/apt/keyrings`
                `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`
                wait
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Adding Docker Repository ------->> "
                `echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`
                wait
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"   
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Updating Database Package ------->> "
                `sudo apt -qq -y update &> /dev/null` #Updating repository with silent options
                wait    
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"    
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Installing Docker CE ------->> "
                `sudo apt -qq -y install docker-ce &> /dev/null` #Updating repository with silent options
                wait    
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Installing Docker CE - Command Line Interface (CLI) ------->> "
                `sudo apt -qq -y install docker-ce-cli &> /dev/null` #Updating repository with silent options
                wait    
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"   
                echo -ne "[${LBLUE}${TIME}${RESET}] [${SCYAN}INFO${RESET}] Installing Docker CE Compose Plugin ------->> "
                `sudo apt -qq -y install docker-compose-plugin &> /dev/null` #Updating repository with silent options
                wait    
                echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"                                                                      
            fi
                    
        else
            echo -e "[${LBLUE}${TIME}${RESET}] [${LRED}ERROR${RESET}] OS not compatible, Your Operating System is ${GREEN}${OSTYPE}${RESET}"
            echo -e "[${LBLUE}${TIME}${RESET}] [${GREEN}INFO${RESET}]  Supported OS ${GREEN}Debian${RESET}, ${GREEN}Ubuntu${RESET}, ${GREEN}Zorin OS${RESET}, ${GREEN}Kubuntu${RESET}, ${GREEN}Xubuntu${RESET} (linux-gnu)"
            exit
        fi
    else
            echo -e "[${LBLUE}${TIME}${RESET}] [${LRED}ERROR${RESET}] OS not compatible, Your Operating System is ${GREEN}${OSTYPE}${RESET}"
            echo -e "[${LBLUE}${TIME}${RESET}] [${GREEN}INFO${RESET}] Supported OS ${GREEN}Debian${RESET}, ${GREEN}Ubuntu${RESET}, ${GREEN}Zorin OS${RESET}, ${GREEN}Kubuntu${RESET}, ${GREEN}Xubuntu${RESET} (linux-gnu)"
            exit
    fi

    checkService() {
    echo -ne "[${LBLUE}${TIME}${RESET}] [${GREEN}INFO${RESET}] Restarting Docker service ------->> "
    `sudo systemctl restart docker &> /dev/null`
    wait
    echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"             
    echo -ne "[${LBLUE}${TIME}${RESET}] [${GREEN}INFO${RESET}] Enabling Docker service ------->> "
    `sudo systemctl enable docker &> /dev/null`
    wait
    echo -e "[${GREEN}DONE${RESET}] ${GREEN}✔${RESET}"       

     echo -ne "[${LBLUE}${TIME}${RESET}] [${GREEN}INFO${RESET}] Docker service status ------->> "
    if [[ $(systemctl is-active docker) == "active" ]]; then
        echo -e "[${GREEN}ACTIVE${RESET}]"
    else
        echo -e "[${LRED}ERROR${RESET}] ${RED}✘${RESET}"
        echo -e "[ ${LBLUE}${TIME}${RESET}] [${RED}ERROR${RESET}] Failed to start Docker, check manually required ${RED}${RED}✘${RESET}${RESET}"   
    fi

    echo "[*] Ended at $(date) | Powered By Mae-X Docker Auto Install"
    }

}

banner
sleep 1;
checkPrivileges
checkOS_package
checkService
exit
