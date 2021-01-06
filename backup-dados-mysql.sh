#!/usr/bin/env bash
#
# backup-dados-mysql.sh - Cria um backup da base de dados MySQL.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - Recebe o nome de base de dados MySQL passada pelo usuário.
#  - Cria um backup utilizando o programa mysqldump.
#
#  Exemplos:
#      $ sudo ./backup-dados-mysql.sh <database_name>
#      $ sudo bash backup-dados-mysql.sh <database_name>
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
CAMINHO_HOME=/home/eddie
BACKUP_DATE=$(date +%F)
# -------------------------------------------------------------------------------------- #

# ------------------------------- TESTES ----------------------------------------------- #
[ ! -d backup ] && mkdir backup # folder backup existe ?
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #
cd $CAMINHO_HOME

# backup da base de dados
mysqldump -u root $1 > $CAMINHO_HOME/backup/${1}_${BACKUP_DATE}.sql

# Verificar status backup
if [ $? -eq 0 ]
then
  echo "Backup realizado com sucesso!"
else
  echo "Houve um problema com o backup."
fi
