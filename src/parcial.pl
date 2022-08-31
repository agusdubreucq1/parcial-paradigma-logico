/*
Nombre: Dubreucq, Agustin
Legajo: 178247-2
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Código Inicial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copiar base de conocimientos inicial aquí

%obejtivo(Proyecto, Objetivo, TipoDeObjetivo)
obejtivo(higiene, almejas, material(playa)).
obejtivo(higiene, algas, material(mar)).
obejtivo(higiene, grasa, material(animales)).
obejtivo(higiene, hidroxidoDeCalcio, quimica([hacerPolvo, diluirEnAgua])).
obejtivo(higiene, hidroxidodeSodio, quimica([mezclarIngredientes])).
obejtivo(higiene, jabon, quimica([mezclarIngredientes, dejarSecar])).

%prerrequisito(ObjetivoPrevio, ObjetivoSiguiente)
prerrequisito(almejas, hidroxidoDeCalcio).
prerrequisito(hidroxidoDeCalcio, hidroxidodeSodio).
prerrequisito(algas, hidroxidodeSodio).
prerrequisito(hidroxidodeSodio, jabon).
prerrequisito(grasa, jabon).

%conseguido(Objetivo)
conseguido(almejas).
conseguido(algas).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Punto 1
sonDelReino(senku).
sonDelReino(chrome).
sonDelReino(kohaku).
sonDelReino(suika).


%puedeTrabajar(Persona, TipoDeObjetivo)

puedeTrabajar(senku, quimica(_)).
puedeTrabajar(chrome, material(Material)):-
    Material \= animales.
puedeTrabajar(kohaku, material(animales)).
puedeTrabajar(chrome, quimica(ListaProcesos)):-
    length(ListaProcesos, CantProcesos),
    CantProcesos =< 3.
puedeTrabajar(senku, artesania(Dificultad)):-
    Dificultad =< 6.
puedeTrabajar(Persona, artesania(Dificultad)):-
    sonDelReino(Persona),
    Dificultad < 3.

%% Punto 2

%% etc...
