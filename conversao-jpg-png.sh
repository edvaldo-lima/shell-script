#!/usr/bin/env bash
#
# conversao-jpg-png.sh - Convert arquivos .jpg para .png
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - O script converte arquivos de imagem com extensão .jpg para .png
#
#  Exemplos:
#      $ sudo bash conversao-jpg-png.sh
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/04/2021, Edvaldo:
#     - Converte arquivos de jpg para png.
#			- Verifica o status da conversão e imprime na tela.
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #

converte_imagem() {

cd ~/Downloads/imagens-livro

[ ! -d png ] && mkdir png # diretório  não existe

for imagem in  *.jpg
do
	local imagem_sem_extensao=$(ls $imagem | awk -F. '{ print $1 }')
	convert $imagem_sem_extensao.jpg png/$imagem_sem_extensao.png
done

}

# chamada da função
converte_imagem 2>erros.log

if [ $? -eq 0 ]
then
	echo "Conversão realizada com sucesso"
else
	echo "Houve uma falha no processo"
fi
