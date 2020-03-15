#include "..\..\script_macros.hpp"
/*
 File: fn_phoneManager.sqf
 Author: nflug
 
 # Author bitte nicht entfernen!
 # Veränderungen an dieser Datei sind erlaubt.
 # Diese Datei wurde unter Auftrag erstellt.
*/
private["_bool"];

_bool = _this select 0;

if(_bool) then {

 _player1 = _this select 1;
 _player2 = _this select 2;
 _index = _this select 3;
  _channelID = (life_phone_extraChannelList select _index);

 _channelID radioChannelAdd [_player1, _player2];
 
 _player1 setVariable ["phone_channelId", _channelID, true];
 _player1 setVariable ["phone_extraChannel", true, true];
 _player2 setVariable ["phone_channelId", _channelID, true];
 _player2 setVariable ["phone_extraChannel", true, true];

 true remoteExec ["life_fnc_phoneChannel", _player1];
 true remoteExec ["life_fnc_phoneChannel", _player2];

} else {

 _player1 = _this select 1;
 _player2 = _this select 2;
 _channelID = _this select 3;

 _channelID radioChannelRemove [_player1, _player2];

 _player1 setVariable ["phone_extraChannel", nil, true];
 _player2 setVariable ["phone_extraChannel", nil, true];
 
 false remoteExec ["life_fnc_phoneChannel", _player1];
 false remoteExec ["life_fnc_phoneChannel", _player2];

};