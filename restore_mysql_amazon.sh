#!/usr/bin/env bash
#
# restore_mysql_amazon.sh - Restaura backups MySQL da AWS.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - O script recebe o nome da tabela a restaurar como parametro.
#  - Faz o download dos dumps da  base de dados MySQL do s3 bucket da AWS.
#  - Importa os dados da tabela passada como parametro para a MySQL DB.
#
#  Exemplos:
#      $ sudo ./restore_mysql_amazon.sh <table_name_to_restore>
#      $ sudo bash restore_mysql_amazon.sh <table_name_to_restore>
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/05/2021, Edvaldo:
#     - Versão inicial do script restaura backups MySQL da AWS.
#
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #

# ------------------------------- VARIÁVEIS -------------------------------------------- #
CAMINHO_RESTORE=/home/eddie/restore_mysql_amazon
NOME_DB=mutillidae # replace by your DB database_name
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #
cd $CAMINHO_RESTORE

# Syncroniza arquivos de dump do S3 bucket da AWS para o caminho espcificado
aws s3 sync s3://curso-shellscript/$(date +%F) $CAMINHO_RESTORE

# verfica se o parametro informado é um nome de tabela valido
# importa o dump file para a DB e imprime o status
if [ -f $1.sql ]
then
  mysql -u root $NOME_DB < $1.sql
  if [ $? -eq 0 ]
  then
    echo "O restore da database $1.sql foi realizado com sucesso!"
  fi
else
  echo "O arquivo $1.sql procurado não existe no diretório"
fi
