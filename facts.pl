% Airplane Distance (km)
link_fly(amsterdam,paris,430).
link_fly(berlin, paris, 878).
link_fly(copenhagen, helsinki, 884).
link_fly(copenhagen, oslo, 484).
link_fly(copenhagen, stockholm, 523).
link_fly(dublin, paris, 836).
link_fly(lisbon, madrid, 503).
link_fly(london, paris, 344).
link_fly(madrid, paris, 1054).
link_fly(paris, rome, 1107).
link_fly(paris, vienna, 1035).

fly(X,Y,D) :-
  link_fly(X,Y,D).
fly(X,Y,D) :-
  link_fly(Y,X,D).

% Car Distance
link_drive(amsterdam, brussels, 210).
link_drive(amsterdam, paris, 501).
link_drive(andorra, ljubjana, 1430).
link_drive(andorra, madrid, 609).
link_drive(andorra, paris, 861).
link_drive(berlin, copenhagen, 356).
link_drive(berlin, paris, 1048).
link_drive(berlin, prague, 351).
link_drive(berlin, tallin, 1042).
link_drive(berlin, warsaw, 572).
link_drive(bratislava, budapest, 200).
link_drive(bratislava, vienna, 79).
link_drive(copenhagen, oslo, 606).
link_drive(copenhagen, stockholm, 657).
link_drive(dublin, paris, 1083).
link_drive(lisbon, madrid, 625).
link_drive(lisbon, porto, 313).
link_drive(ljubjana, vienna, 384).
link_drive(ljubjana, zagreb, 140).
link_drive(london, paris, 464).
link_drive(luxembourg, paris, 374).
link_drive(madrid, paris, 1276).
link_drive(madrid, porto, 561).
link_drive(olso, stockholm, 521).
link_drive(paris, rome, 1424).
link_drive(paris, vienna, 1236).
link_drive(prague, vienna, 309).
link_drive(riga, tallin, 309).
link_drive(riga, vilnius, 302).
link_drive(vilnius, warsaw, 459).

drive(Origin, Destination, Distance) :-
    link_drive(Origin, Destination, Distance).
drive(Origin, Destination, Distance) :-
    link_drive(Destination, Origin, Distance).

% Vehicle Costs (for km & kg of weight)
fly_cost(0.05). 
drive_cost(0.01).

% Vehicle average velocity (km/h)
fly_average_velocity(500).
drive_average_velocity(80).