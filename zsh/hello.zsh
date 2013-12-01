#################
#A message print on shell login
#################

echo -e "Salut $fg[green]$USER$reset_color ! Bienvenue sur $fg[blue]$(uname -n)$reset_color :) "
#echo -e "\e[1;32mfortune bashfr" 
echo -en "\e[1;33m"
fortune bashfr
echo -e "\e[0m"