/*
	Autor: Felix von Studsinske
	Dateiname: fn_PersoUpdateKomplett.sqf
	Beschreibung:
		
	Hinweis/additional information - ausgenommen siehe auf www.von-studsinske.de:
	DE:	Du darfst meine Scripts/Funktionen/Dateien/Bilder/usw. nicht ohne meine Erlaubnis nutzen!
	EN: You are not allowed to use my data/scripts/functions/mission/pictures/etc. without my permission!
*/
params [
	["_PersoID",-1,[0]],
	["_Array",[],[[]]]
];
_Array = [_Array] call DB_fnc_mresArray;
_Befehl = format["UPDATE perso SET Persodaten='%1' WHERE PersoID='%2';",_Array,_PersoID];
[_Befehl,1] call DB_fnc_asyncCall;