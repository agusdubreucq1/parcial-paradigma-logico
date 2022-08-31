/*
Nombre: Dubreucq, Agustin
Legajo: 178247-2
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Código Inicial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Copiar base de conocimientos inicial aquí

%objetivo(Proyecto, Objetivo, TipoDeObjetivo)
objetivo(higiene, almejas, material(playa)).
objetivo(higiene, algas, material(mar)).
objetivo(higiene, grasa, material(animales)).
objetivo(higiene, hidroxidoDeCalcio, quimica([hacerPolvo, diluirEnAgua])).
objetivo(higiene, hidroxidodeSodio, quimica([mezclarIngredientes])).
objetivo(higiene, jabon, quimica([mezclarIngredientes, dejarSecar])).

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
puedeTrabajar(suika, material(playa)).
puedeTrabajar(suika, material(bosque)).
puedeTrabajar(suika, quimica([mezclarIngredientes])).

    

%% Punto 2

objetivoFinal(Proyecto, Objetivo):-
    objetivo(Proyecto ,Objetivo,_),
    %forall((objetivo(Proyecto, OtroObjetivo,_),OtroObjetivo \= Objetivo))
    not((objetivo(Proyecto, OtroObjetivo,_),OtroObjetivo \= Objetivo, prerrequisito(Objetivo, OtroObjetivo))).


%% punto 3

indispensable(Persona, Objetivo):-
    sonDelReino(Persona),
    objetivo(_,Objetivo, TipoDeObjetivo),
    puedeTrabajar(Persona, TipoDeObjetivo),
    not((sonDelReino(OtraPersona),OtraPersona\=Persona,puedeTrabajar(OtraPersona, TipoDeObjetivo))).

%% punto 4

puedeIniciarse(Objetivo):-
    objetivo(_,Objetivo,_),
    not(conseguido(Objetivo)),
    forall(prerrequisito(OtroObjetivo, Objetivo), conseguido(OtroObjetivo)).

%%punto 5

tiempoProyecto(Proyecto, Tiempo):-
    objetivo(Proyecto,_,_),
    findall(TiempoObjetivo, (objetivoPendiente(Proyecto,ObjetivoPendiente),tiempoObjetivo(ObjetivoPendiente, TiempoObjetivo)),ListaTiempo),
    sumlist(ListaTiempo, Tiempo).


tiempoObjetivo(Objetivo, Tiempo):-
    objetivo(_,Objetivo, TipoDeObjetivo),
    tiempoTipoDeObjetivo(TipoDeObjetivo, Tiempo).

tiempoTipoDeObjetivo(material(Lugar), 3):-
    superficie(Lugar).

tiempoTipoDeObjetivo(material(mar), 8).
tiempoTipoDeObjetivo(material(cuevas), 48).

tiempoTipoDeObjetivo(quimica(ListaProcesos), Tiempo):-
    length(ListaProcesos, CantProcesos),
    Tiempo is CantProcesos*2.

tiempoTipoDeObjetivo(artesania(Dificultad), Dificultad).

superficie(Lugar):-
    objetivo(_,_,material(Lugar)),
    Lugar \= mar,
    Lugar \= cuevas.



objetivoPendiente(Proyecto, ObjetivoPendiente):-
    objetivo(Proyecto, ObjetivoPendiente,_),
    not(conseguido(ObjetivoPendiente)).

% punto 6

critico(Objetivo, Proyecto):-
    objetivo(Proyecto, Objetivo,_),
    bloqueaAvance(Objetivo, ObjetivoBloqueado),
    objetivoCostoso(ObjetivoBloqueado).

objetivoCostoso(Objetivo):-
    tiempoObjetivo(Objetivo, Tiempo),
    Tiempo > 5.

bloqueaAvance(Objetivo, ObjetivoBloqueado):-
    prerrequisito(Objetivo, ObjetivoBloqueado).
bloqueaAvance(Objetivo, ObjetivoBloqueado):-
    prerrequisito(OtroObjetivo, ObjetivoBloqueado),
    bloqueaAvance(Objetivo, OtroObjetivo).

%punto 7

convieneTrabajarSobre(Persona, Objetivo, Proyecto):-
    puedeIniciarse(Objetivo),
    objetivo(Proyecto,Objetivo, TipoDeObjetivo),
    puedeTrabajar(Persona, TipoDeObjetivo),
    debeCumplir(Persona, Objetivo, Proyecto).

debeCumplir(Persona, Objetivo, Proyecto):-
    indispensable(Persona, Objetivo),
    critico(Objetivo, Proyecto).

debeCumplir(_, Objetivo, Proyecto):-
    tiempoObjetivo(Objetivo,TiempoObjetivo),
    tiempoProyecto(Proyecto, TiempoProyecto),
    TiempoObjetivo > (TiempoProyecto/2).
debeCumplir(Persona, Objetivo, Proyecto):-
    sonDelReino(Persona),
    objetivo(Proyecto, Objetivo,_),
    forall((objetivo(Proyecto, OtroObjetivo,_),puedeIniciarse(OtroObjetivo),OtroObjetivo\=Objetivo), (puedeTrabajar(OtraPersona, OtroObjetivo),OtraPersona\=Persona)).



