#!/usr/bin/env bash
#
# monitoração-servidor.sh - Monitora o status do servidor apache.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#   - Verifica se o status da requisicao http é diferente de 200.
#   - Envia alerta por e-mail ao sysadmin e reinicia o serviço apache2.
#
#  Exemplos:
#      $ sudo bash monitoração-servidor.sh
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/06/2021, Edvaldo:
#     - Versão inicial do script que retorna http_code.
#     - Envia e-mail ao sysadmin caso o status diferente de 200.
#
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #
#
# ------------------------------- VARIÁVEIS -------------------------------------------- #
resposta_http=$(curl --write-out %{http_code} --silent --out /dev/null http://<apache_server>)
# -------------------------------------------------------------------------------------- #

# ------------------------------- TESTES ----------------------------------------------- #
[ ! -x "$(which ssmtp)" ] && sudo apt-get install ssmtp -y     # ssmtp not installed ?
[ ! -x "$(which mail)" ]  && sudo apt-get install mailutils -y # mailutils installed ?
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #
if [ $resposta_http -ne 200 ]
then
mail -s "Problema no servidor" emaildestinoaqui@gmail.com <<del
Houve um problema no servidor, usuários sem acesso ao conteúdo web!!!
del
  systemctl restart apache2
fi
