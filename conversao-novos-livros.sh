#!/usr/bin/env bash
#
# conversao-novos-livros.sh - Varre diretórios e converte arquivos .jpg para .png
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - O script varre o diretório ~/Downloads/imagens-novos-livros e sub-diretorios.
#  - Converte arquivos de imagem com extensão .jpg para .png
#
#  Exemplos:
#      $ sudo bash conversao-novos-livros.sh
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/04/2021, Edvaldo:
#     - varre o diretório ~/Downloads/imagens-novos-livros e sub-dirs, converte arquivos.
#			- Verifica o status da conversão e imprime na tela.
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #

converte_imagem(){

local caminho_imagem=$1
local imagem_sem_extensao=$(ls $caminho_imagem | awk -F. '{ print $1 }')
convert $imagem_sem_extensao.jpg $imagem_sem_extensao.png

}

varrer_diretorio (){

cd $1

for arquivo in *
do
	local caminho_arquivo=$(find ~/Downloads/imagens-novos-livros -name $arquivo)
		if  [ -d $caminho_arquivo ]
		then
			varrer_diretorio $caminho_arquivo
		else
			converte_imagem $caminho_arquivo
		fi
done

}
# ------------------------------- EXECUÇÃO -------------------------------- #

# chamada da função
varrer_diretorio ~/Downloads/imagens-novos-livros 2>errors.log

# Verifica exit status code
if [ $? -eq 0 ]
then
		echo "Conversão realizada com sucesso!"
else
		echo "Houve uma falha no processo de conversão!!!"
fi
# ------------------------------------------------------------------------ #
