#!/bin/bash

### CORES
amarelo="\e[33;1m"
azul="\e[34;1m"
verde="\e[32;1m"
vermelho="\e[31;1m"
fim="\e[m"

# BROWSER AGENT
AGENT="Mozilla/5.0 (Windows NT 10.0; WOW64)"
FILE="wordlist_url.txt"

banner()
{
echo "#  2▄222222222▄22▄▄▄▄▄▄▄▄▄▄▄22▄222222222▄22▄▄▄▄▄▄▄▄▄▄▄22▄▄▄▄▄▄▄▄▄▄▄22▄▄▄▄▄▄▄▄▄▄▄22▄▄▄▄▄▄▄▄▄▄▄2"
echo "#  ▐░▌2222222▐░▌▐░░░░░░░░░░░▌▐░▌2222222▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌"
echo "#  ▐░▌2222222▐░▌▐░█▀▀▀▀▀▀▀█░▌▐░▌2222222▐░▌2▀▀▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀2▐░█▀▀▀▀▀▀▀▀▀2▐░█▀▀▀▀▀▀▀▀▀2"
echo "#  ▐░▌2222222▐░▌▐░▌2222222▐░▌▐░▌2222222▐░▌2222222222▐░▌▐░▌2222222222▐░▌2222222222▐░▌2222222222"
echo "#  ▐░█▄▄▄▄▄▄▄█░▌▐░▌2222222▐░▌▐░▌222▄222▐░▌2▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄2▐░█▄▄▄▄▄▄▄▄▄2▐░▌2222222222"
echo "#  ▐░░░░░░░░░░░▌▐░▌2222222▐░▌▐░▌22▐░▌22▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌2222222222"
echo "#  ▐░█▀▀▀▀▀▀▀█░▌▐░▌2222222▐░▌▐░▌2▐░▌░▌2▐░▌▐░█▀▀▀▀▀▀▀▀▀22▀▀▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀2▐░▌2222222222"
echo "#  ▐░▌2222222▐░▌▐░▌2222222▐░▌▐░▌▐░▌2▐░▌▐░▌▐░▌22222222222222222222▐░▌▐░▌2222222222▐░▌2222222222"
echo "#  ▐░▌2222222▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌░▌222▐░▐░▌▐░█▄▄▄▄▄▄▄▄▄22▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄2▐░█▄▄▄▄▄▄▄▄▄2"
echo "#  ▐░▌2222222▐░▌▐░░░░░░░░░░░▌▐░░▌22222▐░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌"
echo "#  2▀222222222▀22▀▀▀▀▀▀▀▀▀▀▀22▀▀2222222▀▀22▀▀▀▀▀▀▀▀▀▀▀22▀▀▀▀▀▀▀▀▀▀▀22▀▀▀▀▀▀▀▀▀▀▀22▀▀▀▀▀▀▀▀▀▀▀2"
echo "#  2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222"
echo -e "$azul##############################################################################################$fim"
echo -e "$azul# By Wellington Luiz da Silva aka w3ll                                                       #$fim"
echo -e "$azul#                                                                                            #$fim"
echo -e "$azul# ROBOTS2WORDLIST Version 1.0 - How2Sec Lab                                                  #$fim"
echo -e "$azul#                                                                                            #$fim"
echo -e "$azul# Created: 05/11/2016  Updated: 05/11/2016                                                   #$fim"
echo -e "$azul##############################################################################################$fim"

echo -e "\012"
}
banner

# Validando se o usuario passou a URL
if [ "$1" == "" ] ;then
	echo -e "$vermelho""[-] ERROR: You need to specify a URL$fim"
	echo -e "$verde""[+] Use: $0 http://www.exemplo.com.br\n$fim"
	exit 1
fi

# Apagando pesquisas anteriores
rm robots.txt

# Fazendo o download passando como parametro o User-Agent do Browser
# Isso para fazer bypass de WAF com filtros de Browsers
wget --user-agent="$AGENT" $1/robots.txt

# Laco FOR para fazer a quebra de linha em conteudos compactados
# Enviamos o resultado para um arquivo temporario /tmp/$$.robots.1
for FILEs in $(grep "/" robots.txt) ;do
	echo $FILEs | grep ^/ >> /tmp/$$.robots.1
done

# Seprarando os Caminhos Encontrados
echo "PATH Encontrados"
echo "================"
cat /tmp/$$.robots.1
echo "\nN de Caminhos|Arquivos encontrados: " `cat /tmp/$$.robots.1 | wc -l`

# Criando o arquivo temporario 2, removendo conteudo repetido
cat $FILE /tmp/$$.robots.1 | sort -u >> /tmp/$$.robots.2
echo "\nN Total de Caminhos|Arquivos: " `cat /tmp/$$.robots.2 | wc -l` 
cat /tmp/$$.robots.2 > $FILE

# Removendo os Arquivos Temporarios
rm /tmp/$$.robots*

echo -e "\n"
echo -e "$verde""[+] Search results saved in: wordlist_url.txt.\n[+]Number of Hits in file: `wc -l $FILE`\n""$fim"
