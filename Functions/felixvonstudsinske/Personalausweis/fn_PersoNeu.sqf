/*
	Autor: Felix von Studsinske
	Dateiname: fn_PersoNeu.sqf
	Beschreibung:
		
	Hinweis/additional information - ausgenommen siehe auf www.von-studsinske.de:
	DE:	Du darfst meine Scripts/Funktionen/Dateien/Bilder/usw. nicht ohne meine Erlaubnis nutzen!
	EN: You are not allowed to use my data/scripts/functions/mission/pictures/etc. without my permission!
*/
params [
	["_Spieler",objNull,[objNull]],
	["_Profilname","",[""]],
	["_PersoSpielername","",[""]],
	["_Array",[],[[]]],
	["_Boolean",false,[false]], // Neue Query
	["_Boolean2",false,[false]], // Perso muss angelegt werden oder neue Identität
	["_Mobilfunknummer","XX ERROR",[""]], // Perso muss angelegt werden oder neue Identität
	"_ownerID","_SpielerUID"
];
_ownerID = remoteExecutedOwner;
if (isNull _Spieler) exitWith {};
_SpielerUID = getPlayerUID _Spieler;
_Spielername_N = name _Spieler;
if (_Profilname isEqualTo "") exitWith {};
if !(_Profilname isEqualTo _Spielername_N) exitWith {
	format["Fehler beim Updaten des Personalausweises: Name ungleich Name, %1(p) - %2(n)",_Profilname,_Spielername_N] remoteExecCall ["systemChat",remoteExecutedOwner];
	uisleep 5;
	"perso_name" remoteExecCall ["endMission",remoteExecutedOwner];
};
// [[1,1,1960],150,45,""Arudy"",""Querstrasse"",1,0,""maennlich"",0,""Adnet""]
if !(_Array isEqualTypeArray [[0,0,0],0,0,"","",0,0,"",0,""]) exitWith {format["Ungleich: [[0,0,0],0,0,"","",0,0,"",0,""] zu %1",_Array] remoteExecCall ["systemChat",remoteExecutedOwner];};
// Personalausweis existent?
_Array = [_Array] call DB_fnc_mresArray;
_Befehl_Perso_Neu = format["INSERT INTO perso (Spielername, SpielerUID, Spielerfraktion, Persodaten, Mobilfunknummer, Originalname) VALUES ('%1','%2','%3','%4','%5','%6');",_PersoSpielername,_SpielerUID, str side _Spieler,_Array,_Mobilfunknummer,_Profilname];
[_Befehl_Perso_Neu,1] call DB_fnc_asyncCall;
uiSleep 1.5;
[_Spieler,side _Spieler,_SpielerUID] call DB_fnc_PersoAbfrage;