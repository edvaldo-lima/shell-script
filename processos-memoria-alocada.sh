#!/usr/bin/env bash
#
# processos-memoria-alocada.sh - Extrai quantidade de memória alocada.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# -------------------------------------------------------------------------------------- #
#  - Verifica os 10 processos que mais consomem memória.
#  - Salva o log de cada um dos processos contendo data, hora e tamanho em MB.
#
#  Exemplos:
#      $ sudo bash processos-memoria-alocada.sh
# -------------------------------------------------------------------------------------- #
# Histórico:
#
#   v1.0 01/04/2021, Edvaldo:
#     - Verifica os 10 processos que mais consomem memória.
#			- Verifica o status da execução do script e imprime na tela.
# -------------------------------------------------------------------------------------- #
# Testado em:
#   bash 5.0.17
#   zsh  5.8
# -------------------------------------------------------------------------------------- #

# ------------------------------- TESTES ----------------------------------------------- #
[ ! -d log ] && mkdir log # diretorio não existe ?
# -------------------------------------------------------------------------------------- #

# ------------------------------- EXECUÇÃO --------------------------------------------- #

processos_memoria(){

  processos=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])

  for pid in $processos
  do
      nome_processo=$(ps -p $pid -o comm=)

      echo -n $(date +%F,%H:%M:%S,) >> log/$nome_processo.log

      tamanho_processo=$(ps -p $pid -o size | grep [0-9])

      echo "$(bc <<< "scale=2;$tamanho_processo/1024") MB" >> log/$nome_processo.log
  done

}

# chamada função
processos_memoria

# obtendo exit code
if [ $? -eq 0 ]
then
  echo "Os arquivos foram salvos com sucesso"
else
  echo "Houve um problema na hora de salvar os arquivos!!!"
fi
