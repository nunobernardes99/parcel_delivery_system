% Module export
:- module(facts, [cidade/5, estrada/3, encomenda/2]).

% Pontos de distribuição e moradas escolhidas na frame

%cidade(Morada, cZona, PosX, PosY, HorarioDisp).
% HorarioDisp = 0 significa sempre disponível
cidade(pontoDistribuicao,7,120,60,0).
cidade(aldoar1,1,20,60,14).
cidade(aldoar2,1,40,80,0).
cidade(nevogilde,2,40,20,20).
cidade(ramalde1,3,60,80,8).
cidade(ramalde2,4,80,60,0).
cidade(lordelo1,5,60,40,0).
cidade(lordelo2,6,80,40,0).
cidade(paranhos1,7,120,80,13).
cidade(paranhos2,8,140,80,11).
cidade(cedofeita1,9,120,40,8).
cidade(cedofeita2,10,100,20,16).
cidade(bonfim1,11,140,40,13).
cidade(bonfim2,12,140,20,12).
cidade(campanha1,13,160,60,8).
cidade(campanha2,14,160,20,10).

% estrada(Cidade1, Cidade2, Distância)
% Estradas ligar uma cidade à outra com distância
estrada(aldoar1,aldoar2,45). 
estrada(aldoar1,nevogilde,32).
estrada(aldoar2,ramalde1,16).
estrada(aldoar2,ramalde2,30). 
estrada(aldoar2,lordelo1,25). 
estrada(nevogilde,lordelo1,30). 
estrada(nevogilde,lordelo2,26). 
estrada(ramalde1,ramalde2,23). 
estrada(ramalde1,paranhos1,37). 
estrada(ramalde2,pontoDistribuicao,22). 
estrada(ramalde2,lordelo2,23). 
estrada(ramalde2,paranhos1,25). 
estrada(lordelo1,lordelo2,25). 
estrada(lordelo1,ramalde1,23). 
estrada(lordelo1,cedofeita2,48). 
estrada(lordelo2,ramalde2,16). 
estrada(lordelo2,cedofeita1,32). 
estrada(paranhos1,paranhos2,23). 
estrada(paranhos1,pontoDistribuicao,20). 
estrada(paranhos1,cedofeita1,22). 
estrada(paranhos1,bonfim1,25). 
estrada(paranhos2,bonfim1,27). 
estrada(paranhos2,paranhos1,23). 
estrada(paranhos2,campanha1,16). 
estrada(cedofeita1,bonfim2,20).
estrada(cedofeita1,lordelo2,19). 
estrada(cedofeita1,ramalde2,22). 
estrada(cedofeita2,cedofeita1,32). 
estrada(cedofeita2,bonfim2,25). 
estrada(cedofeita2,aldoar2,34). 
estrada(bonfim1,paranhos2,20). 
estrada(bonfim1,cedofeita2,25). 
estrada(bonfim1,campanha1,15). 
estrada(bonfim2,cedofeita1,31).
estrada(bonfim2,campanha2,22).
estrada(bonfim2,cedofeita1,29).
estrada(bonfim2,campanha1,44).
estrada(bonfim2,paranhos2,62).
estrada(campanha1,paranhos2,33).
estrada(campanha1,campanha2,18).
estrada(campanha1,bonfim1,43).
estrada(campanha2,bonfim2,27).
estrada(campanha2,campanha1,18).
estrada(pontoDistribuicao,paranhos1,17).
estrada(pontoDistribuicao,paranhos2,23).
estrada(pontoDistribuicao,cedofeita1,20).
estrada(pontoDistribuicao,bonfim1,28).
estrada(pontoDistribuicao,paranhos1,17).
estrada(pontoDistribuicao,campanha1,45).
estrada(pontoDistribuicao,ramalde2,51).

%encomenda(Dest, HoraMaximaEntre)
encomenda(ramalde1,0).
encomenda(campanha1,0).
% encomenda(aldoar2,0).
% encomenda(paranhos1,0).
% encomenda(paranhos2,0).
% encomenda(lordelo1,0).