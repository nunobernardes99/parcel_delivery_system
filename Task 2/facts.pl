% Module export
:- module(facts, [caminhos/3, minimo/2]).

estrada(centro_distribuicao, b1, 49).
estrada(centro_distribuicao, b2, 43).
estrada(centro_distribuicao, a2, 21).
estrada(a2, c1, 14).
estrada(c1, b2, 28).
estrada(c1, c2, 24).
estrada(b1, d1, 47).
estrada(b2, b1, 12).
estrada(b2, d1, 45).
estrada(b2, c2, 32).
estrada(b2, e1, 39).
estrada(c2, e2, 37).
estrada(c2, e1, 25).
estrada(e1, d1, 23).
estrada(e1, e2, 26).
estrada(e1, f1, 29).
estrada(d1, d2, 38).
estrada(e2, f2, 27).
estrada(d2, f1, 26).
estrada(d2, g1, 39).
estrada(f1, f2, 20).
estrada(f1, g1, 36).
estrada(f2, g2, 22).
estrada(g2, g1, 33).

% Argumento que torna possível a bidirecionalidade dos nós
% sem ser necessário a repetição contrária de todos os factos.
caminhos(X,Y,L) :- estrada(X,Y,L) ; estrada(Y,X,L).

% Função auxiliar para analisar qual caminho é mínimo.
minimo([F|R],M) :- min(R,F,M).
min([],M,M).
min([[P,L]|R],[_,M],Min) :- L < M, min(R,[P,L],Min). 
min([_|R],M,Min) :- min(R,M,Min).