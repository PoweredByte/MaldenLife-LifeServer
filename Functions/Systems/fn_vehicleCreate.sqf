/*
    File: fn_vehicleCreate.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Answers the query request to create the vehicle in the database.
*/
private ["_uid","_side","_type","_classname","_color","_plate"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_side = [_this,1,sideUnknown,[west]] call BIS_fnc_param;
_vehicle = [_this,2,objNull,[objNull]] call BIS_fnc_param;
_color = [_this,3,-1,[0]] call BIS_fnc_param;

//Error checks
if (_uid isEqualTo "" || _side isEqualTo sideUnknown || isNull _vehicle) exitWith {};
if (!alive _vehicle) exitWith {};
_className = typeOf _vehicle;
_type = switch (true) do {
    case (_vehicle isKindOf "Car"): {"Car"};
    case (_vehicle isKindOf "Air"): {"Air"};
    case (_vehicle isKindOf "Ship"): {"Ship"};
};

_side = switch (_side) do {
    case west: {"cop"};
    case civilian: {"civ"};
    case independent: {"med"};
    case east: {"adac"};
    default {"Error"};
};
if(_vehicle == "I_Heli_light_03_F") then {
  private _pylons = ["PylonRack_4Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel"];
  private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
  { _vehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _vehicle;
  { _vehicle setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;
};
if(_vehicle == "B_Heli_Attack_01_F") then {
  private _pylons = ["PylonMissile_1Rnd_AAA_missiles","PylonMissile_1Rnd_AAA_missiles","PylonMissile_1Rnd_LG_scalpel","PylonRack_12Rnd_PG_missiles","PylonMissile_1Rnd_AAA_missiles","PylonMissile_1Rnd_AAA_missiles"];
  private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
  { _vehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _vehicle;
  { _vehicle setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;
};
if(_vehicle == "B_Plane_Fighter_01_F") then {
  private _pylons = ["PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Bomb_GBU12_x2","PylonRack_Bomb_GBU12_x2","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"];
  private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
  { _vehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _vehicle;
  { _vehicle setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;
};
if(_vehicle == "B_UAV_05_F") then {
  private _pylons = ["",""]; 
  private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
  { _vehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _vehicle;
  { _vehicle setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;
};

_plate = round(random(1000000));
[_uid,_side,_type,_classname,_color,_plate] call DB_fnc_insertVehicle;

_vehicle setVariable ["dbInfo",[_uid,_plate],true];
