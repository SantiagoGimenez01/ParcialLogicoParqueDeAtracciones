% Personas,parques y atracciones
% De cada persona, conocemos su edad y altura, aquí van algunos ejemplos:
% ● Nina es una joven de 22 años y 1.60m.
% ● Marcos es un niño de 8 años y 1.32m.
% ● Osvaldo es un adolescente de 13 años y 1.29m.

% edad(Persona, Años).
edad(nina, 22).
edad(marcos, 8).
edad(osvaldo, 13).
% mide(Persona, Altura)
mide(nina, 1.69).
mide(marcos, 1.32).
mide(osvaldo, 1.29).
% grupoEtario(Persona, Grupo)
grupoEtario(nina, joven).
grupoEtario(marcos, ninio).
grupoEtario(osvaldo, adolescente).

esPersona(Persona):-
    edad(Persona, _).

% tieneAtraccion(Parque, Atraccion).
tieneAtraccion(parqueDeLaCosta, trenFantasma).
tieneAtraccion(parqueDeLaCosta, montaniaRusa).
tieneAtraccion(parqueDeLaCosta, maquinaTiquetera).
tieneAtraccion(parqueAcuatico, toboganGigante).
tieneAtraccion(parqueAcuatico, rioLento).
tieneAtraccion(parqueAcuatico, piscinaDeOlas).


% Punto 1
% puedeSubir(Persona, Atraccion)
puedeSubir(Persona, Atraccion):-
    esPersona(Persona),
    cumpleRequisito(Persona, Atraccion),
    estaHabilitada(Persona, Atraccion).

estaHabilitada(Persona, _):-
    tienePasaporte(Persona, pasaportePremium).
estaHabilitada(Persona, Atraccion):-
    esJuegoPremium(Atraccion),
    tienePasaporte(Persona, pasaporteFlex(_, Atraccion)).
estaHabilitada(Persona, Atraccion):-
    esJuegoBasico(Atraccion, Creditos),
    tienePasaporte(Persona, pasaporteFlex(CreditoDisponible, _)),
    CreditoDisponible >= Creditos. 
estaHabilitada(Persona, Atraccion):-
    esJuegoBasico(Atraccion, Creditos),
    tienePasaporte(Persona, pasaporteBasico(CreditoDisponible)),
    CreditoDisponible >= Creditos.

% cumpleRequisito(Persona, Atraccion).
cumpleRequisito(_, maquinaTiquetera).
cumpleRequisito(_, rioLento).
cumpleRequisito(Persona, Atraccion):-
    edad(Persona, Edad),
    edadMinima(Atraccion, Minimo),
    Edad >= Minimo.
cumpleRequisito(Persona, Atraccion):-
    mide(Persona, Altura),
    alturaMinima(Atraccion, Minimo),
    Altura >= Minimo.
% Requisitos
edadMinima(trenFantasma, 12).
edadMinima(piscinaDeOlas, 5).
alturaMinima(montaniaRusa, 1.30).
alturaMinima(toboganGigante, 1.50).
% Juegos
esJuegoPremium(trenFantasma).
esJuegoPremium(toboganGigante).
esJuegoPremium(montaniaRusa).
esJuegoBasico(maquinaTiquetera, 500).
esJuegoBasico(rioLento, 150).
esJuegoBasico(piscinaDeOlas, 300).


% Punto 2
% esParaElle(Parque, Persona)
esParaElle(Parque, Persona):-
    esPersona(Persona),
    tieneAtraccion(Parque, _),
    forall(tieneAtraccion(Parque, Atracciones), puedeSubir(Persona, Atracciones)).

% Punto 3
malaIdea(GrupoEtario, Parque):-
    grupoEtario(Persona, GrupoEtario),
    tieneAtraccion(Parque, _),
    forall(tieneAtraccion(Parque, Atraccion), not(puedeSubir(Persona, Atraccion))).

% Punto 4
programaLogico(Programa):-
    sonTodosDelMismoParque(Programa),
    noHayJuegoRepetido(Programa).

sonTodosDelMismoParque(Programa):-
    tieneAtraccion(Parque, _),
    forall(member(Juegos, Programa), tieneAtraccion(Parque, Juegos)).

noHayJuegoRepetido([Cabeza | Cola]):-
    not(member(Cabeza, Cola)),
    noHayJuegoRepetido(Cola).
noHayJuegoRepetido([]).

% hastaAca(Persona, Programa, SubPrograma)
hastaAca(Persona, [Cabeza | Cola], [Cabeza | ColaSub]):-
    puedeSubir(Persona, Cabeza),
    hastaAca(Persona, Cola, ColaSub).

hastaAca(Persona, [Cabeza | _], []):-
    not(puedeSubir(Persona, Cabeza)).

hastaAca(_, [], []).

% pasaporteBasico(Creditos)
% pasaporteFlex(Creditos, JuegoPremium)
% pasaportePremium

% tienePasaporte(Persona, Pasaporte).
tienePasaporte(nina, pasaportePremium).
tienePasaporte(marcos, pasaporteBasico(500)).
tienePasaporte(osvaldo, pasaporteFlex(300, trenFantasma)).





    








