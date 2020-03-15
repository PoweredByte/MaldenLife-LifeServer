#define SEL(arr,val) (arr select val)
/*
	Autor: Felix von Studsinske
	Dateiname: fn_PersoNeu.sqf
	Beschreibung:
		[player,playerside,PUID] remoteExec ["DB_fnc_PersoAbfrage",2];
		
	Hinweis/additional information - ausgenommen siehe auf www.von-studsinske.de:
	DE:	Du darfst meine Scripts/Funktionen/Dateien/Bilder/usw. nicht ohne meine Erlaubnis nutzen!
	EN: You are not allowed to use my data/scripts/functions/mission/pictures/etc. without my permission!
*/
params [
	["_Spieler",objNull,[objNull]],
	["_SpielerFraktion",sideUnknown,[sideUnknown]],
	["_SpielerUID","",[""]]
];
if (isNull _Spieler) exitWith {};
if !(_SpielerFraktion in [west,civilian,east,independent]) exitWith {};
if (_SpielerUID isEqualTo "") exitWith {};
if !isRemoteExecuted exitWith {};
if (remoteExecutedOwner < 2) exitWith {};
_Limit = getArray(missionConfigFile >> "CfgPerso" >> "Einstellungen" >> "MaximaleIdentitaeten");
_Limit = switch _SpielerFraktion do {case west: {SEL(_Limit,0);};case civilian: {SEL(_Limit,1);};case east: {SEL(_Limit,3);};case independent: {SEL(_Limit,2);}; default {0};};
if (_Limit < 1) exitWith {diag_log format["Perso (Abfrage): Error in _Limit - %1",_this];};
_Befehl = format["SELECT PersoID, Spielername, SpielerUID, Spielerfraktion, Persodaten, Ausstelldatum, Mobilfunknummer, Originalname FROM perso WHERE SpielerUID='%1' AND Spielerfraktion='%2' LIMIT 0,%3;",_SpielerUID, str _SpielerFraktion,_Limit];
_Rueckgabe = [_Befehl,2,true] call DB_fnc_asyncCall;
{
	_Persodaten = _x select 4;
	_xx = +_x;
	_Persodaten = [_Persodaten] call DB_fnc_mresToArray;
	_xx set [4,str _Persodaten];
	_Rueckgabe set [_forEachIndex,_xx];
} forEach _Rueckgabe;
[_Rueckgabe] remoteExecCall ["life_fnc_PersoAbfrageRueckgabe",remoteExecutedOwner];