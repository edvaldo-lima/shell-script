#!/usr/bin/env bash
#
# filtrando-resultado-apache.sh - Filtra conteúdo de arquivo de log Apache.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - O script recebe um IP como parametro e filtra o conteúdo do log.
#  - Utiliza regex everificase o usuário forneceu um formato de IP válido.
#  - Verifica se o IP fornecido é encontrado no arquivo de log.
#
#  Exemplos:
#      $ sudo bash iltrando-resultado-apache.sh <ip_address>
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/06/2021, Edvaldo:
#     - Versão inicial do script que filtra o conteúdo do log Apache.
#
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #
#
# ------------------------------- VARIÁVEIS -------------------------------------------- #
regex="\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #
cd ~/apache-log

# compara parametro com expressão regular e mostra status
if [[ $1 =~ $regex ]]
then
  grep $1 apache.log
  if [ $? -ne 0 ]
  then
    echo "O ip informado não está presente no arquivo!"
  fi
else
  echo "Formato não é valido!"
fi
