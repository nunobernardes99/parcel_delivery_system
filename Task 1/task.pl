% Carregar modulo de factos
:- use_module(facts).

% Testar a tarefa:
% tarefa(porto, lisbon, date(2020, 11, 30, 18, 0, 0, 0, _, _), 1, Barato, Rapido).
% tarefa(oslo, warsaw, date(2020, 11, 30, 7, 30, 0, 0, _, _), 1, Barato, Rapido).
% tarefa(budapest, porto, date(2020, 11, 30, 8, 0, 0, 0, _, _), 1, Barato, Rapido).

tarefa(Orig, Dest, Data, Peso, Perc, Perc1):- 
    percursoMaisBarato(Orig, Dest, Peso, Perc), 
    percursoMaisRapido(Orig, Dest, Data, Perc1).

% Percurso Mais Barato: preco utilizado + tempo utilizado, transporte utilizado
% Percurso Mais Rápido: tempo de duracao + transporte utilizado

% Algoritmo Branch & BOund - Tarefa 1 Método 1 Mais barato
percursoMaisBarato(Orig, Dest, Peso, Perc) :-
    go1([((0,0), [Orig])], Dest, Peso, P),
    reverse(P, Perc).

% Caso final
go1([((C, Y), Prim)| _], Dest, Peso, Prim) :- 
    Prim = [Dest| _],
    formatar_custo(C, Euros, Centimos),
    formatar_duracao(Y, Horas, Minutos),
    write('==========================[ PERCURSO ENCONTRADO ]=========================='), nl,
    write('Percurso Mais Barato: '), nl,
    write('Peso Encomenda: '), write(Peso), write(' Kg'), nl,
    write('Custo: '), write(Euros), write(' Euros e '), write(Centimos), write(' Centimos'), nl,
    write('Tempo de duração: '), write(Horas), write(' horas e '), write(Minutos), write(' minutos'), nl.
    
% Interromper, Continuar a pesquisa no Resto
go1([(_, _), [Dest| _]| Resto], Dest, Peso, Perc) :- ! , go1(Resto, Dest, Peso, Perc).
go1([((C, Y), [Ult| T])| Outros], Dest, Peso, Perc) :-
    findall(
        ((NC, NY), [Z, Tipo, Ult| T]),
        (proximo_no(Ult, T, Z, C1, Tipo),
        ((Tipo == 'car', NC is ((C + C1 * 0.01) + (Peso * 0.01)), NY is Y + (C1/80));
        (Tipo == 'flight', NC is ((C + C1 * 0.05) + (Peso * 0.05)), NY is Y + (C1/500)))),
        Lista),
    append(Outros, Lista, NPerc),
    sort(NPerc, NPerc1),
    go1(NPerc1, Dest, Peso, Perc).

% Função auxiliar para salta de nós método 1
proximo_no(X, T, Z, C, Tipo) :- trip(Tipo, X, Z, C),  \+ member(Z, T).

formatar_custo(C, Euros, Centimos) :-
    Euros is integer(C),
    Centimos is integer((C - Euros) * 100).

formatar_duracao(Y, Horas, Minutos) :-
    Horas is integer(Y / 0.6),
    Minutos is integer((Horas - (Y / 0.6)) * 100).


% Tarefa 1 Método 2 mais rápido
percursoMaisRapido(Orig, Dest, DataHora, Perc) :-
    date_time_stamp(DataHora, Segundos),
    SegundosFinal = Segundos,
    go2([(0, [Orig])], Dest, Segundos, SegundosFinal, P),
    reverse(P, Perc).

% Caso final
go2([(C, Prim)| _], Dest, Segundos, _, Prim) :-
    Prim = [Dest| _], nl,
    write('Percurso Mais Rápido: '), nl, SFinal is Segundos + C, stamp_date_time(SFinal, DataFinal, 0),
    date_time_value(year, DataFinal, Ano), date_time_value(month, DataFinal, Mes), date_time_value(day, DataFinal, Dia),
    write('Data de Chegada: '), write(Dia), write('/'), write(Mes), write('/'), write(Ano),
    date_time_value(hour, DataFinal, Hora), date_time_value(minute, DataFinal, Minuto),
    write(' Horas de Chegada: '), write(Hora), write(':'), write(Minuto), nl,
    write('==========================[ BARATO / RÁPIDO ]=========================='), nl.

% Interromper, Continuar a pesquisa no Resto
go2([(_, [Dest| _])| Resto], Dest, Segundos, SegundosFinal, Perc) :- !, go2(Resto, Dest, Segundos, SegundosFinal, Perc).
go2([(C, [Ult| T])| Outros], Dest, Segundos, _, Perc) :-
    findall(
        (NC, [Z, Tipo, Ult| T]),
        (proximo_noh(Ult, T, Z, C1), SegundosAux is Segundos  + C,
        verificaDisponibilidade(SegundosAux, Count, Tipo),
        ((Tipo == 'car', NC is (C * ((C1/80) * 3600) + Count));
        (Tipo == 'flight', NC is (C + ((C1/500) * 3500) + Count)))),
        Lista),
    append(Outros, Lista, NPerc),
    sort(NPerc, NPerc1),
    go2(NPerc1, Dest, Segundos, Segundos, Perc).

% Função auxiliar para saltar de nós método 2
proximo_noh(X, T, Z, C) :- trip(_, X, Z, C), \+ member(Z, T).   