/*
	Autor: Felix von Studsinske
	Dateiname: fn_PersoPreInitServer.sqf
	Beschreibung:
		
	Hinweis/additional information - ausgenommen siehe auf www.von-studsinske.de:
	DE:	Du darfst meine Scripts/Funktionen/Dateien/Bilder/usw. nicht ohne meine Erlaubnis nutzen!
	EN: You are not allowed to use my data/scripts/functions/mission/pictures/etc. without my permission!
*/
_Exit = false;
if !(isNil "FWFVS_Array_Serverteamausweis") then {
	FWFVS_Array_Serverteamausweis = nil;
	if !(isNil "FWFVS_Array_Serverteamausweis") then {_Exit = true;};
};
if (_Exit) exitWith {for "_i" from 0 to 5 do {diag_log "Perso-PreInitError: FWFVS_Array_Serverteamausweis existiert bereits!";};};
FWFVS_Array_Serverteamausweis = compileFinal str [
	// Format:  ["SteamID", "Serverteamname", "Stellungsbezeichnung"]
	["7656XXXSTEAM64ID","SPIELERNAME","RANGNAME"]
];
publicVariable "FWFVS_Array_Serverteamausweis";