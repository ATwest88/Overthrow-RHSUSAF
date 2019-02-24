params ["_ctrl","_index"];

disableSerialization;

private _id = _ctrl lbData _index;
_s = _id splitString "-";
_s params ["_cls","_qty"];
_qty = parseNumber _qty;
_def = [];
{
    _x params ["_c","_r","_q"];
    if(_cls isEqualTo _c && _q isEqualTo _qty) exitWith {_def = _x};
}foreach(OT_craftableItems);

if(count _def > 0) then {
    _def params ["_cls","_recipe","_qty"];

    _textctrl = (findDisplay 8000) displayCtrl 1100;
    _itemName = "";

    _recipeText = "";
    {
        _x params ["_rcls","_rqty"];
        _name = "";
        call {
            if(_rcls isEqualTo "Uniform_Base") exitWith {
                _name = "Clothing";
            };
            if(_rcls isKindOf ["Default", configFile >> "CfgMagazines"]) then {
                _name = _rcls call OT_fnc_magazineGetName;
            }else{
                _name = _rcls call OT_fnc_weaponGetName;
            };
        };
        _recipeText = _recipeText + format["%1 x %2<br/>",_rqty,_name];
    }foreach(_recipe);
    _desc = "";
    _pic = "";

    if(_cls isKindOf ["Default", configFile >> "CfgMagazines"]) then {
        _desc = getText(configFile >> "CfgWeapons" >> _cls >> "descriptionShort");
        _itemName = _cls call OT_fnc_magazineGetName;
        _pic = _cls call OT_fnc_magazineGetPic;
    }else{
        _desc = getText(configFile >> "CfgMagazines" >> _cls >> "descriptionShort");
        _itemName = _cls call OT_fnc_weaponGetName;
        _pic = _cls call OT_fnc_weaponGetPic;
    };

    _textctrl ctrlSetStructuredText parseText format["
    	<t align='center' size='1.1'>%1 x %2</t><br/>
        <t align='center' size='0.7'>%3</t><br/><br/>
        <t align='center' size='0.8'>Recipe:</t><br/>
        <t align='center' size='0.7'>%4</t><br/>
    ",_qty,_itemName,_desc,_recipeText];

    if !(isNil "_pic") then {
    	ctrlSetText [1200,_pic];
    };
};
