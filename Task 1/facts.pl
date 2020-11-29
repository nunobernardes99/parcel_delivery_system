% Module export
:- module(facts, [trip/4, disponibilidade/3, verificaDisponibilidade/3]).

%Trip Flight
trip(flight,amesterdam,paris,430).
trip(flight,berlin,paris,878).
trip(flight,copenhagen,helsinki,884).
trip(flight,copenhagen,oslo,484).
trip(flight,copenhagen,stockholm,523).
trip(flight,dublin,paris,836).
trip(flight,helsinki,copenhagen,884).
trip(flight,lisbon,madrid,503).
trip(flight,london,paris,344).
trip(flight,madrid,lisbon,503).
trip(flight,madrid,paris,1054).
trip(flight,oslo,copenhagen,484).
trip(flight,paris,amesterdam,430).
trip(flight,paris,berlin,878).
trip(flight,paris,dublin,836).
trip(flight,paris,london,344).
trip(flight,paris,madrid,1054).
trip(flight,paris,rome,1107).
trip(flight,paris,vienna,1035).
trip(flight,rome,paris,1107).
trip(flight,stockholm,copenhagen,523).
trip(flight,vienna,paris,1035).
 
%Trip Car
trip(car,amesterdam,brussels,210).
trip(car,amesterdam,paris,501).
trip(car,andorra,ljubljana,1430).
trip(car,andorra,madrid,609).
trip(car,andorra,paris,861).
trip(car,berlin,copenhagen,356).
trip(car,berlin,paris,1048).
trip(car,berlin,prague,351).
trip(car,berlin,tallin,1042).
trip(car,berlin,warsaw,572).
trip(car,bratislava,budapest,200).
trip(car,bratislava,vienna,79).
trip(car,brussels,amesterdam,210).
trip(car,brussels,paris,314).
trip(car,budapest,bratislava,200).
trip(car,copenhagen,berlin,356).
trip(car,copenhagen,oslo,606).
trip(car,copenhagen,stockholm,657).
trip(car,dublin,paris,1083).
trip(car,lisbon,madrid,625).
trip(car,lisbon,porto,313).
trip(car,ljubljana,andorra,1430).
trip(car,ljubljana,vienna,384).
trip(car,ljubljana,zagreb,140).
trip(car,london,paris,464).
trip(car,luxembourg,paris,374).
trip(car,madrid,andorra,609).
trip(car,madrid,lisbon,625).
trip(car,madrid,paris,1276).
trip(car,madrid,porto,561).
trip(car,oslo,copenhagen,606).
trip(car,oslo,stockholm,521).
trip(car,paris,amesterdam,501).
trip(car,paris,andorra,861).
trip(car,paris,berlin,1048).
trip(car,paris,brussels,314).
trip(car,paris,dublin,1083).
trip(car,paris,london,464).
trip(car,paris,luxembourg,374).
trip(car,paris,madrid,1276).
trip(car,paris,rome,1424).
trip(car,paris,vienna,1236).
trip(car,porto,lisbon,313).
trip(car,porto,madrid,561).
trip(car,prague,berlin,351).
trip(car,prague,vienna,309).
trip(car,riga,tallin,309).
trip(car,riga,vilnius,302).
trip(car,rome,paris,1424).
trip(car,stockholm,copenhagen,657).
trip(car,stockholm,oslo,657).
trip(car,tallin,riga,309).
trip(car,tallin,berlin,1042).
trip(car,vienna,bratislava,79).
trip(car,vienna,ljubljana,384).
trip(car,vienna,paris,1236).
trip(car,vienna,prague,309).
trip(car,vilnius,riga,302).
trip(car,vilnius,warsaw,459).
trip(car,warsaw,vilnius,459).
trip(car,warsaw,berlin,572).
trip(car,zagreb,ljubljana,140).

%0.01 car km 80km/h
%0.05 flight km 500km/h

%car 7 as 12
%flight 2-4-5-6 horas
disponibilidade(car,1,7).
disponibilidade(car,1,12).
disponibilidade(flight,2,6).
disponibilidade(car,2,7).
disponibilidade(car,2,12).
disponibilidade(car,3,7).
disponibilidade(car,3,12).
disponibilidade(flight,4,6).
disponibilidade(car,4,7).
disponibilidade(car,4,12).
disponibilidade(car,5,7).
disponibilidade(car,5,12).
disponibilidade(flight,6,6).
disponibilidade(car,6,7).
disponibilidade(car,6,12).
disponibilidade(car,7,7).
disponibilidade(car,7,12).

% Base de Conhecimento Teste
% Trip Flight
% trip(flight,porto,lisboa,300).
% trip(flight,lisboa,porto,300).
% trip(flight,paris,berlim,500).
% trip(flight,berlim,paris,500).
%
% Trip Car
% trip(car,amesterdam,berlim,116).
% trip(car,amesterdam,lisboa,10).
% trip(car,berlim,lisboa,710).
% trip(car,porto,paris,250).
% trip(car,lisboa,berlim,710).
% trip(car,lisboa,amesterdam,10).
% trip(car,lisboa,paris,640).
% trip(car,paris,lisboa,640).
% trip(car,paris,porto,250).
% trip(car,berlim,amesterdam,116).

% Verificar disponibilidade de avião ou carro
% Função auxiliar para método 2

% Situação Ideal Horas Minutos
verificaDisponibilidade(DataHora, Count, TipoFinal) :-
    stamp_date_time(DataHora, DataHoraAux, 'UTC'),
    date_time_value(date, DataHoraAux,Data), day_of_the_week(Data, Dia),
    date_time_value(hour, DataHoraAux, Hora),
    date_time_value(minute, DataHoraAux, Minuto),
    Minuto == 0,											 
    disponibilidade(TipoFinal, Dia, Hora), 
    Count is 0.

% Situação Ideal Minutos - Hora diferente												 
verificaDisponibilidade(DataHora, Count, TipoFinal):- 
    stamp_date_time(DataHora, DataHoraAux, 'UTC'),
    date_time_value(date, DataHoraAux, Data), day_of_the_week(Data, Dia),
    date_time_value(hour, DataHoraAux, Hora),	
    date_time_value(minute, DataHoraAux, Minuto),
    disponibilidade(TipoFinal, Dia, HoraDisp),
    HoraDisp > Hora, Count is ((HoraDisp - Hora) * 3600) - (Minuto * 60).	

verificaDisponibilidade(DataHora, Count, TipoFinal):-
    stamp_date_time(DataHora, DataHoraAux, 'UTC'),
    date_time_value(date, DataHoraAux, Data), day_of_the_week(Data, Dia),
    date_time_value(hour, DataHoraAux, Hora),	
    date_time_value(minute, DataHoraAux, Minuto),
    disponibilidade(TipoFinal, Dia, HoraDisp),
    HoraDisp < Hora, Hora < 12, Count is ((12 - Hora) * 3600) - (Minuto * 60).	
    
verificaDisponibilidade(DataHora, Count, TipoFinal):-
    stamp_date_time(DataHora, DataHoraAux, 'UTC'),
    date_time_value(hour, DataHoraAux, Hora),
    date_time_value(minute,DataHoraAux,Minuto),
    Hora > 12, Minuto == 0, Count1 is ((24 - Hora) * 3600) - (Minuto * 60),
    DataHora2 is DataHora + Count1,
    verificaDisponibilidade1(DataHora2, Count, Count1, TipoFinal).

verificaDisponibilidade(DataHora, Count, TipoFinal):- 
    stamp_date_time(DataHora, DataHoraAux, 'UTC'),
    date_time_value(hour, DataHoraAux, Hora),
    date_time_value(minute, DataHoraAux, Minuto),
    Hora >= 12, Minuto > 0, Count1 is ((24 - Hora) * 3600) - (Minuto * 60),
    DataHora2 is DataHora + Count1,
    verificaDisponibilidade1(DataHora2, Count, Count1, TipoFinal).
       
verificaDisponibilidade1(DataHora, Count, Count1, TipoFinal):- 
    stamp_date_time(DataHora, DataHoraAux, 'UTC'),
    date_time_value(date, DataHoraAux, Data), day_of_the_week(Data,Dia),
    date_time_value(hour, DataHoraAux, Hora),
    date_time_value(minute, DataHoraAux, Minuto),
    disponibilidade(TipoFinal, Dia, HoraDisp),
    Hora == 0,
    Count is (Count1 + ((HoraDisp - Hora) * 3600) - (Minuto * 60)).	
    