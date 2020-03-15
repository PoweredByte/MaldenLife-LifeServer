/*
	Autor: Felix von Studsinske
	Dateiname: fn_PersoUpdate.sqf
	Beschreibung:
		
	Hinweis/additional information - ausgenommen siehe auf www.von-studsinske.de:
	DE:	Du darfst meine Scripts/Funktionen/Dateien/Bilder/usw. nicht ohne meine Erlaubnis nutzen!
	EN: You are not allowed to use my data/scripts/functions/mission/pictures/etc. without my permission!
*/
params [
	["_Spieler",objNull,[objNull]],
	["_Profilname","",[""]],
	["_SpielerUID","",[""]],
	["_PersoID",-1,[0]]
];
_Befehl = format["UPDATE perso SET Originalname='%1',Spielername='%1' WHERE PersoID='%2';",_Profilname,_PersoID];
[_Befehl,1] call DB_fnc_asyncCall;
uiSleep 1;
[_Spieler,side _Spieler,_SpielerUID] spawn DB_fnc_PersoAbfrage;