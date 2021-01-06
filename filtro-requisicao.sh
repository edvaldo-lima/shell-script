#!/usr/bin/env bash
#
# filtro-requisicao.sh - Filtra log Apache por tipo de requisição.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - O script recebe um parametro (GET,POST,PUT,DELETE) e filtra o conteúdo do log.
#  - Valida se o usuario não passou nenhum parametro ou parametro invalido.
#
#  Exemplos:
#      $ sudo bash filtro-requisicao.sh <ip_address>
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/06/2021, Edvaldo:
#     - Versão inicial do script que filtra um log Apache por tipo de requisição.
#
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #
cd ~/apache-log

if [ -z $1 ] # parametro 1 vazio
then
    while [ -z $requisicao ] # variavel requisacao vazia, repete loop
    do
      read -p "Favor digitar o parâmetro (GET,POST,PUT,DELETE): " requisicao
      letra_maiuscula=$(echo $requisicao | awk '{ print toupper ($1) }')
    done
else
    letra_maiuscula=$(echo $1 | awk '{ print toupper ($1) }')
fi

# faz o filtro do log de acordo com parametro passado pelo usuario
case $letra_maiuscula in

  GET)    grep GET apache.log                 ;;

  POST)   grep POST apache.log                ;;

  PUT)    grep PUT apache.log                 ;;

  DELETE) grep DELETE apache.log              ;;

  *) echo "Parâmetro informado não é válido!" ;; 

esac
