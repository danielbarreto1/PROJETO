#!/bin/bash



source ./funcoes.sh


while true;do
	echo "=======D=a=n=i=e=l==M=e=d=e=i=r=o=s========"
	echo "|           BACKUP SHELLSCRIPT            |"
	echo "======P=r=o=j=e=t=o===3=P=e=r=i=o=d=o======"
		

	echo " "



	echo "===================MENU===================="
	
	echo "1) Inicio"
	echo "2) Iniciar Processo de Backup"
	echo "3) Listar dispositivos disponíveis"
	echo "4) Adicionar um dispositivo"
	echo "5) Remover um dispositivo"
	echo "6) Listar Backups Salvos "
	echo "7) Agendar um backup"
	echo "8) Finalizar"

	read -p "Selecione uma opção: " opcao
	case $opcao in

		"1") limpar;;
		"2") limpar
		     Realizar_Backup;;
	     	"3") Dispositivos;;
		"4") Cadastrar_PC;;
		"5") Remover_pc;;
		"6") Backups_salvos;;
		"7") agendar_backup;;
		"8") echo 'Adeus...'
		     break;;
	esac
done

