#!/usr/bin/env bash
#
# backup_mysql_amazon.sh - Cria um backup de uma MySQL DB na AWS.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - Cria backup das tabelas de um base de dados MySQL utilizando o programa mysqldump.
#  - Envia os backups para um AWS S3 bucket.
#
#  Exemplos:
#      $ sudo ./backup-mysql-amazon.sh <database_name>
#      $ sudo bash backup-mysql-amazon.sh <database_name>
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/05/2021, Edvaldo:
#     - Versão inicial do script que cria backup de databases MySQL.
#
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #
#
# ------------------------------- VARIÁVEIS -------------------------------------------- #
CAMINHO_BACKUP=/home/eddie/backup_mysql_amazon
DATA=$(date +%F)
NOME_DB=mutillidae # replace by your DB database_name
cd $CAMINHO_BACKUP
# -------------------------------------------------------------------------------------- #

# ------------------------------- TESTES ----------------------------------------------- #
[ ! -d $DATA ] && mkdir $DATA   # folder 'yyyy-mm-dd' existe ?
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #

# filtra apenas nomes de cada tabela da DB
tabelas=$(mysql -u root $NOME_DB -e "show tables;" | grep -v Tables)

# Faz o dump de cada uma das tabelas da DB no caminha espcificado
for tabela in $tabelas
do
  mysqldump -u root $NOME_DB $tabela > $CAMINHO_BACKUP/$DATA/$tabela.sql
done

# Syncroniza arquivos de dump locais para o S3 bucket da AWS
aws s3 sync $CAMINHO_BACKUP s3://curso-shellscript

# Verificar status backup
if [ $? -eq 0 ]
then
  echo "Backup realizado com sucesso!"
else
  echo "Houve um problema com o backup."
fi
