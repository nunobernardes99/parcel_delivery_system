% Load external modules
:- use_module(facts).

criaListaEncomendas(L) :- findall([X, Y], encomenda(X, Y), L).

entregaEncomenda(Perc, Total) :- 
    criaListaEncomendas(LE), 
    entregaEncomendas(LE, Perc, Total).
entregaEncomendas([Dest| T], Perc, Total) :-
    nth1(1, Dest, X),
    hbf('pontoDistribuicao', X, Perc, Total),
    entregaEncomendas(X, T, Perc, Total).
% Lista Vazia
entregaEncomendas(Orig, [[]], Perc, Total) :-
    hbf(Orig, 'pontoDistribuicao', Perc, Total).
entregaEncomendas(Orig, [Dest| T], Perc, Total) :-
    nth1(1, Dest, X), hbf(Orig, X, Perc, Total),
    entregaEncomendas(X, T, Perc, Total).

% Método de Pesquisa A-star

hbf(Orig, Dest, Perc, Total) :-
    write(Orig), write(Dest),
    estimativa(Orig, Dest, H), F is H + 0,
    hbf1([c(F/0, [Orig])], Dest, P, Total),
    reverse(P, Perc).

hbf1(Percursos, Dest, Percurso, Total) :-
    menor_percurso(Percursos, Menor, Restantes),
    percursos_seguintes(Menor, Dest, Restantes, Percurso, Total).

percursos_seguintes(c(_/Dist, Percurso), Dest, _, Percurso, Dist) :- Percurso = [Dest| _].
percursos_seguintes(c(_, [Dest| _]), Dest, Restantes, Percurso, Total) :- 
    !, hbf1(Restantes, Dest, Percurso, Total).
percursos_seguintes(c(_/Dist, [Ult| T]), Dest, Percursos, Percurso, Total) :-
    findall(
        c(F1/D1, [Z, Ult| T]),
        proximo_no(Ult, T, Z, Dist, Dest, F1/D1),
        Lista),
    append(Lista, Percursos, NovosPercursos),
    hbf1(NovosPercursos, Dest, Percurso, Total).

proximo_no(X, T, Y, Dist, Dest, F/Dist1) :- 
    (estrada(X, Y, Z); estrada(Y, X, Z)), \+ member(Y, T),
    Dist1 is Dist + Z,
    estimativa(Y, Dest, H), F is H + Dist1.

estimativa(C1, C2, Est) :-
    cidade(C1, _, X1, Y1, _),
    cidade(C2, _, X2, Y2, _),
    DX is X1 - X2,
    DY is Y1 - Y2,
    Est is sqrt(DX * DX + DY * DY).

menor_percurso([Percurso| Percursos], Menor, [Percurso| Resto]) :-
    menor_percurso(Percursos, Menor, Resto), menor(Menor, Percurso), !.
menor_percurso([Percurso| Resto], Percurso, Resto).

menor(c(H1/D1, _), c(H2/D2, _)) :-
    C1 is H1 + D1,
    C2 is H2 + D2,
    C1 < C2.