# Sistema de entrega de encomendas postais
- Programming Language: Prolog
- Curricular unit: [Programming in Logic](https://sigarra.up.pt/fcup/pt/ucurr_geral.ficha_uc_view?pv_ocorrencia_id=464482)

# 1. Objetivo
Uma empresa de transporte de encomendas que opera no continente europeu tem uma série de centros de distribuição em países da Europa de onde pode encaminhar encomendas para outros centros do mesmo ou de outros países por via aérea e/ou terrestre. Uma encomenda é enviada para o centro mais próximo da morada de destino e depois é encaminhado para essa morada a partir desse centro por via terrestre. 
Este trabalho tem por objetivo a implementação de software que permita a pesquisa de caminhos, preços e horários associados ao transporte de encomendas feito pela Pegasus Express assim como determinar percursos ótimos para a distribuição local de encomendas. O trabalho divide-se em duas tarefas principais:
1. Pesquisa de caminhos de entrega de encomendas em centros de distribuição (dentro
do continente europeu) e segundo restrições de tempo e preços.
2. Determinar o percurso ótimo para a entrega de encomendas numa dada localidade.

Estas tarefas são explicadas nas secções seguintes.
# 2. Pesquisa de caminhos para envio de encomendas
A distruibuidora tem uma série de centros de distribuição em capitais de países da Europa de onde pode encaminhar as encomendas para outros centros por via terrestre e/ou aérea. No ficheiro Excel pode encontrar tabelas com as distâncias por via terrestre e aérea entre as diferentes cidades aonde a distruibuidora tem representação.
Esta fase do trabalho tem por objetivo:
1. Descrever a informação nas tabelas sob a forma de factos em Prolog.
2. Determinar, dada uma origem, um destino, data, hora e peso, qual o percurso mais
barato e mais rápido e respetivos tempos de duração, preço associado e tipos de
transporte utilizados.
a. O valor cobrado por via terrestre é de 0.01 € por km e kg de peso enquanto
que o preço cobrado por via aérea é de 0.05 € por km e kg de peso.
b. Assume-se uma velocidade média de 80kms/h por via terrestre e de 500kms/h
por via aérea.
c. O transporte por via terrestre é feito todos os dias às 7.00 e às 12.00.
d. O transporte por via aérea é feito às 3as, 5as e sábados às 6.00.

# 3. Percursos para entrega de encomendas
A entrega de encomendas a partir do ponto de distribuição mais próximo da morada de destino é feita por via terrestre por um estafeta da empresa que conduz um veículo de mercadorias que transporta as encomendas. Nesta fase terá que desenvolver um programa que dê ao estafeta o percurso que deve percorrer de forma a minimizar a distância percorrida e voltando no final das entregas ao centro de distribuição de onde partiu. Para esta parte, utilizará como exemplo o mapa da cidade do porto dividido em subáreas correspondentes às freguesias.
![Mapa do Porto](https://user-images.githubusercontent.com/37451431/98048814-61015580-1e26-11eb-9f3a-3299c2e04822.png)

Note o seguinte:
- Assume-se que entregas feitas dentro da mesma área têm um custo temporal fixo de
10 minutos.
- As encomendas podem ter associadas horas máximas para entrega que devem ser
cumpridas tanto quanto possível.
- Os destinatários podem indicar o horário em que estão disponíveis para receber as
encomendas.

Deve modelar o mapa e implementar um gerador de percursos tendo em conta as restrições
enunciadas anteriormente. O percurso de teste que criar terá que ter no mínimo 15 pontos de
entrega definidos.