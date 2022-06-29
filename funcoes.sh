#!/bin/bash


#FUNÇÕES UTILIZADAS NO SCRIPT

#Função de limpar tela
function limpar(){
        clear
}


#Função para listar backups já salvos
function Backups_salvos(){
	clear
	echo "Backups Disponíveis"
	ls -R "${PWD}/Backups/"
}

#Função para cadastrar novo pc para backup
function Cadastrar_PC(){
	clear
	pcs=$(( $(wc -l < ips.txt) + 1 ))
	read -p "Digite o nome do usuário:" user
	read -p "Digite o IP:" ip
	echo "PC$pcs $user $ip" >> ips.txt
	echo -e "Sucesso!\n"
}


#Função para remover dispositivo
function Remover_pc(){
        clear
        cat ips.txt
        read -p "Selecione o número do PC que você deseja remover: " pc
        sed -i $pc'd' ips.txt
        echo "PC$pc Removido com sucesso."
}




#Função para saber quais os dispositivos disponíveis
function Dispositivos(){
	clear
	echo -e "Dispositivos disponíveis\n"
	cat ips.txt
}


#Realizar o backup via conexão SCP
function Realizar_Backup(){
        clear
        format=$(date +"%F-%H%M%S")
        arquivo_backup="backup_$format.tar.gz"
        cat ips.txt
        read -p 'Escolha qual PC Deseja realizar o backup: ' pc
        user=$(cat ips.txt | grep PC-$pc | awk '{print $2}')
        ip=$(cat ips.txt | grep PC-$pc | awk '{print $3}')
        read -p 'Qual pasta você deseja fazer o backup?' pasta
        mkdir -p "${PWD}/Backups/PC-$pc/$(basename $pasta)" &> /dev/null
        scp -r "$user@$ip:$pasta" "${PWD}/Backups/PC-$pc/$(basename $pasta)"

        #compactar em tar constando a data e pasta
        tar -czvf $arquivo_backup "${PWD}/Backups/PC_$ip/$(basename $pasta)/$(basename $pasta)"
        clear
        rm -rf "${PWD}/Backups/PC-$pc/$(basename $pasta)/$(basename $pasta)"
        cp $arquivo_backup "./Backups/PC-$pc/$(basename $pasta)"
        rm $arquivo_backup
        echo "Backup Salvo em ${PWD}/Backups/PC-$pc/$(basename $pasta)"
        echo ""
}





#Agendar Backup
function agendar_backup() {
	clear
	read -p 'Qual agendamento gostaria de fazer: 
       			1 - Backup a cada hora
			2 - Backup a cada dia
			3 - Backup a cada semana
			4 - Fazer backup agora	' time

	case $time in 

		1) 
			function Backup1HR() {
				clear
				echo "Confira as informações antes de agendar o backup!"
				eformat=$(date +"%F-%H%M%S")
 	      	        	arquivo_backup="backup_$format.tar.gz"
        			cat ips.txt
       				read -p 'Escolha qual PC Deseja agendar o backup: ' pc
        			user=$(cat ips.txt | grep PC-$pc | awk '{print $2}')
        			ip=$(cat ips.txt | grep PC-$pc | awk '{print $3}')
        			read -p 'Qual pasta você deseja fazer o backup?' pasta	
				echo
				echo -n "Continuar? (s/n)"
				read cont
				case $cont in
       				 s) time1 ;;
       				 n) echo ; exit ;;
     			 	 *) echo "Opção inválida." echo; Backup1HR ;;
			

			esac
			}
			Backup1HR
			;;

		2) 
			function Backup24HR() {
				clear
                        echo "Confira as informações antes de agendar o backup diário!"
                        eformat=$(date +"%F-%H%M%S")
                        arquivo_backup="backup_$format.tar.gz"
                        cat ips.txt
                        read -p 'Escolha qual PC Deseja agendar o backup: ' pc
                        user=$(cat ips.txt | grep PC-$pc | awk '{print $2}')
                        ip=$(cat ips.txt | grep PC-$pc | awk '{print $3}')
                        read -p 'Qual pasta você deseja fazer o backup?' pasta
                        echo
                        echo -n "Continuar? (s/n)"
                        read cont
                        case $cont in
                         s) time2 ;;
                         n) echo ; exit ;;
                         *) echo "Opção inválida." echo; Backup24HR ;;


                        esac
                        }
                        Backup24HR
                        ;;


		3) 
			function Backup7D() {

				 clear
                        echo "Confira as informações antes de agendar o backup semanal!!"
                        eformat=$(date +"%F-%H%M%S")
                        arquivo_backup="backup_$format.tar.gz"
                        cat ips.txt
                        read -p 'Escolha qual PC Deseja agendar o backup: ' pc
                        user=$(cat ips.txt | grep PC-$pc | awk '{print $2}')
                        ip=$(cat ips.txt | grep PC-$pc | awk '{print $3}')
                        read -p 'Qual pasta você deseja fazer o backup?' pasta
                        echo
                        echo -n "Continuar? (s/n)"
                        read cont
                        case $cont in
                         s) time2 ;;
                         n) echo ; exit ;;
                         *) echo "Opção inválida." echo; Backup24HR ;;


                        esac
                        }
                        Backup7D
                        ;;
	

		4) 
			clear
			Realizar_Backup
			;;



	esac	


		


} 






function time1() {
clear
rsync -auv $origem/ $destino/ --progress --log-file=$logfile
clear
back="rsync -auv $origem/ $destino/ --progress --delete --log-file=$logfile"
cront="0 * * * * $back"
(crontab -l 2>/dev/null; echo "$cront") | crontab -
echo
echo "Backup a cada hora agendado!"


}


function time2() {
clear
rsync -auv $origem/ $destino/ --progress --delete --log-file=$logfile
clear
back="rsync -auv $origem/ $destino/ --progress --delete --log-file=$logfile"
cront="0 0 * * * $back"
(crontab -l 2>/dev/null; echo "$cront") | crontab -
echo
echo "Backup diário agendado!"


}


time3() {
clear
rsync -auv $origem/ $destino/ --progress --delete --log-file=$logfile
clear
back="rsync -auv $origem/ $destino/ --progress --delete --log-file=$logfile"
cront="0 0 * * 0 $back"
(crontab -l 2>/dev/null; echo "$cront") | crontab -
echo
echo "Backup semanal agendado!"


}













