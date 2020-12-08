% Carregar modulo de factos
:- use_module(facts).

% Função principal
% Testes:
%   estafeta([])
%   estafeta([b1, d1, d2, g2])
%   estafeta([d1, f2, c1, b1, g2])
estafeta([]) :- format('Preencha a lista de encomendas com valores'),  halt().
estafeta(Encomendas) :-
      % Afirmação: O destino mais longe do centro de distribuição será o último a ser entregue.
      entrega_mais_longe(Encomendas, 0, centro_distribuicao, Destino), 
      % Procurar o caminho mais curto desde o centro até ao destino calculado encima.
      % Para cada caminho retornado verificar se o Percurso contêm todas as moradas das
      % Encomendas. Se contiver, retornar ao centro de distribuição.
      caminho_mais_curto(centro_distribuicao, Destino, PercursoIda, DistanciaIda),
      verificar_solucao(Encomendas, PercursoIda),
      % Caminho mais curto e ótimo desde o destino até à origem (retornar à base)
      caminho_mais_curto(Destino, centro_distribuicao, [HVolta| PercursoVolta], DistanciaVolta),
      % Concatenar caminho de entregas e de retorno à base e respetivas distâncias
      append(PercursoIda, PercursoVolta, PercursoTotal),
      DistanciaTotal is DistanciaIda + DistanciaVolta,
      % Retornar resultados
      format('+~`-t~78|+ ~n', []),
      format('Percurso de ida -> ~w, Distância de ida -> ~w ~n', [PercursoIda, DistanciaIda]),
      format('Percurso de volta -> ~w, Distância de volta -> ~w ~n ~n', [[HVolta| PercursoVolta], DistanciaVolta]),
      format('Percurso total -> ~w, Distância total -> ~w ~n', [PercursoTotal, DistanciaTotal]),
      format('+~`-t~78|+ ~n', []), !.

% Função que investiga qual dos nós onde é necessário entregar
% encomendas está mais longe do centro de distribuição
entrega_mais_longe([], _, Max, Max).
entrega_mais_longe([Encomenda| Encomendas], DistanciaMaxima, _, Max) :-
       caminho_mais_curto(centro_distribuicao, Encomenda, _, DistanciaAtual),
       DistanciaAtual >= DistanciaMaxima,
       entrega_mais_longe(Encomendas, DistanciaAtual, Encomenda, Max).
entrega_mais_longe([Encomenda| Encomendas], DistanciaMaxima, NoMaximo, Max) :-
       caminho_mais_curto(centro_distribuicao, Encomenda, _, DistanciaAtual),
       DistanciaAtual < DistanciaMaxima,
       entrega_mais_longe(Encomendas, DistanciaMaxima, NoMaximo, Max).

% Função que verifica se no conjunto de nós visitados a solução existe
verificar_solucao([], _).
verificar_solucao([Encomenda|Encomendas], Visitados) :-
    member(Encomenda, Visitados),
    verificar_solucao(Encomendas, Visitados).

% Função que itera pelos vários percursos
percurso(A,B,Path,Len) :-
       proximo_no(A,B,[A],Q,Len), 
       reverse(Q,Path).

% Função que "viaja" para o nó seguinte do nó onde estamos
proximo_no(A,B,P,[B|P],L) :- 
       caminhos(A,B,L).
proximo_no(A,B,Visited,Path,L) :-
       caminhos(A,C,D),           
       C \== B,
       \+member(C,Visited),
       proximo_no(C,B,[C|Visited],Path,L1),
       L is D+L1.  

% Função que retorna todas as soluções organizadas de forma ótima
% (caminho mais curto)
caminho_mais_curto(A,B,Path,Length) :-
   setof([P,L],percurso(A,B,P,L),Set),
   Set = [_|_], % falha se vazio
   minimo(Set,[Path,Length]).