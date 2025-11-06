% Scrivere un programma in Prolog che ricerchi il percorso più breve tra due nodi “places”
% all'interno di un grafo. Sono forniti i seguenti fatti, che rappresentano gli archi del grafo: 

edge(placeA, placeB, 11).
edge(placeA, placeC, 26).
edge(placeA, placeD, 37).
edge(placeA, placeE, 13).
edge(placeA, placeF, 96).
edge(placeB, placeE, 73).
edge(placeB, placeC, 14).
edge(placeC, placeD, 5).
edge(placeC, placeH, 24).
edge(placeD, placeH, 71).
edge(placeE, placeG, 123).
edge(placeG, placeH, 20).
edge(placeF, placeH, 29). 

% caso base predicato path. Path è una lista di nodi. 
path(X, X, [X], 0).
path(X, Y, [X|Path], TotalCost) :-
	edge(X, N, Cost),
	path(N, Y, Path, PathCost),
	TotalCost is PathCost + Cost.

% all_paths mi trova tutti i percorsi possibili tra due nodi salvando anche il costo totale
all_paths(X, Y, Paths) :- findall((Path, TotalCost),path(X, Y, Path, TotalCost),Paths).

% predicato find_best_path che trova il percorso migliore tra due nodi che useremo per la query finale
find_best_path(X, Y, BestPath) :-
    all_paths(X, Y, Paths),
	best_path(Paths, BestPath).


best_path([(Path, Cost)], (Path, Cost)).
best_path([(Path,Cost)|RemainingPaths], (BestPath,BestCost)) :-
    best_path(RemainingPaths, (OtherPath, OtherCost)),

    % usiamo un if-then-else per memorizzare il percorso migliore e il costo migliore
    (
        Cost < OtherCost -> 
        BestPath = Path, 
        BestCost = Cost
        
        ;

        BestPath = OtherPath,
        BestCost = OtherCost
        
    ).