/*
	Autor: Felix von Studsinske
	Dateiname: fn_PersoLoeschen.sqf
	Beschreibung:
		
	Hinweis/additional information - ausgenommen siehe auf www.von-studsinske.de:
	DE:	Du darfst meine Scripts/Funktionen/Dateien/Bilder/usw. nicht ohne meine Erlaubnis nutzen!
	EN: You are not allowed to use my data/scripts/functions/mission/pictures/etc. without my permission!
*/
params [
	["_Spieler",objNull,[objNull]],
	["_SpielerUID","",[""]],
	["_PersoID",-1,[0]]
];
_Befehl = format["DELETE FROM perso WHERE PersoID='%1' AND SpielerUID='%2';",_PersoID,_SpielerUID];
[_Befehl,1] call DB_fnc_asyncCall;
uiSleep 1;
[_Spieler,side _Spieler,_SpielerUID] spawn DB_fnc_PersoAbfrage;