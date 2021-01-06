#!/usr/bin/env bash
#
# verificacao-memoria-consumida.sh - Verifica % atual de memória RAM consumida.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - Verifica % atual de memória RAM consumida.
#  - Envia um e-mail ao sysadmin se o % de RAM consumida estiver acima de 50% to total.
#
#  Exemplos:
#      $ sudo verificacao-memoria-consumida.sh
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/04/2021, Edvaldo:
#     - Verifica % atual de memória RAM consumida.
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #

# ------------------------------- TESTES ----------------------------------------------- #
[ ! -d log ] && mkdir log # diretorio não existe ?
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #

memoria_total=$(free | grep -i mem | awk '{ print $2 }')
memoria_cosumida=$(free | grep -i mem | awk '{ print $3 }')
relacao_memoria_atual_total=$(bc <<< "scale=2;$memoria_cosumida/$memoria_total * 100" | awk -F . '{ print $1 }')
memoria_formatada=$(free -h | grep -i mem | awk '{ print $3 }')

if [ $relacao_memoria_atual_total > 50 ]
then

mail -s "Consumo de memória acima do limite" seu_email@gmail.com<<del
O consumo de memória está acima do limite que foi especificado.

Atualmente o consumo de memória é de: $memoria_formatada
del

fi
