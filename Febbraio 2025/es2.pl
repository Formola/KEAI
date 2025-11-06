% Dati i seguenti fatti, costruire un funtore “computer”:

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
    write(Component), nl, 
    findall(SubComponent, compostoDa(Component, SubComponent), SubComponents),
    build_subfunctors(SubComponents, SubComponentsFunctors),
    Functor =.. [Component | SubComponentsFunctors].

build_subfunctors([], []).
build_subfunctors([Component | Rest], [Functor | FunctorsRest]) :-
    build_functor(Component, Functor),
    build_subfunctors(Rest, FunctorsRest).

build_computer_functor(ComputerFunctor) :-
    build_functor(computer, ComputerFunctor).

