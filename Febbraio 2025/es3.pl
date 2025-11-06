% Ispezionare ricorsivamente il funtore “computer” creato nel punto precedente, stampando su
% un file il nome di tutti i componenti.

compostoDa(computer, schedaMadre).
compostoDa(computer, periferiche).
compostoDa(schedaMadre, schedaVideo).
compostoDa(schedaMadre, unitàControllo).
compostoDa(schedaMadre, cpu).
compostoDa(schedaMadre, ram).
compostoDa(unitàControllo, alu).
compostoDa(cpu, registri).
compostoDa(periferiche, perifericheInput).
compostoDa(periferiche, perifericheOutput).
compostoDa(perifericheInput, tastiera).
compostoDa(perifericheInput, mouse).
compostoDa(perifericheOutput, monitor).
compostoDa(perifericheOutput, stampante).

build_functor(Component, Functor) :-
	findall(SubComponent,
		compostoDa(Component, SubComponent),
		SubComponents),
	build_subfunctors(SubComponents, SubComponentsFunctors),
	Functor =.. [Component|SubComponentsFunctors].

build_subfunctors([], []).
build_subfunctors([Component|Rest], [Functor|FunctorsRest]) :-
	build_functor(Component, Functor),
	build_subfunctors(Rest, FunctorsRest).

build_computer_functor(ComputerFunctor) :-
	build_functor(computer, ComputerFunctor).


% esercizio 3 in cui si chiede di ispezionare il funtore computer creato in esercizio 2

write_computer_functor_to_file(ComputerFunctor) :-
    open('computer_functor.txt', write, Fd),
    inspect_functor(Fd, ComputerFunctor),
    close(Fd).

% predicato principale che ci serve per recuperare nome e arità di ogni funtore,
% all'interno chiameremo un predicato poi per ispezionarne gli argomenti
% caso base ci serve quando ispezionando un argomento non troviamo più sottofuntori
% ma un atomo che comunque dobbiamo stampare nel file
inspect_functor(File, Atom) :- atom(Atom), write(File, Atom), write(File, '\n').
inspect_functor(File, Functor) :-

    % recuperiamo nome e arità del funtore con functor
    functor(Functor, Name, Arity),
    write(File, Name),
    write(File, '\n'),
    inspect_functor_args(File, Functor, Arity).

inspect_functor_args(_, _, 0).
inspect_functor_args(File, Functor, N) :-
    % usiamo arg per recuperare l'argomento N-esimo del funtore
    arg(N, Functor, Arg),
    inspect_functor(File, Arg),
    N1 is N - 1,
    inspect_functor_args(File, Functor, N1).

