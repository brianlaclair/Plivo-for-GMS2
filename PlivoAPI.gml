//This script includes functions to impliment Plivo (plivo.com) with GameMaker Studio
//Please note that this is NOT an official SDK or implimentation.


/// @function plivo_init(AuthID, AuthToken);
/// @param {string} AuthID Your Plivo Authorization ID
/// @param {string} AuthToken Your Plivo Authorization Token

function plivo_init(_AuthID, _AuthToken)
{
	//Creates a DS Map for the header we need to send requests to Plivo - this includes your Auth_ID and Auth_Token
	
	global.Auth = _AuthID;
	
	_pliv_map = ds_map_create();
	ds_map_add(_pliv_map, "Host", "api.plivo.com");
	ds_map_add(_pliv_map, "Connection", "keep-alive");
	ds_map_add(_pliv_map, "Authorization", "Basic "+string(base64_encode(_AuthID+":"+_AuthToken)));
	ds_map_add(_pliv_map, "Content-Type", "application/json");
	
	global.plivo_map = _pliv_map;
	
}

/// @function plivo_text(From, To, Message);
/// @param {string} From The number to send the message from
/// @param {string} To The number to send the message to
/// @param {string} Message The Message

function plivo_text(_From, _To, _Message)
{
	
	//Sends an SMS message to the specified number from a Plivo number (owned by you)
	
	_msg_data = @'{"dst": "'+_To+@'", "src": "'+_From+@'", "text": "'+_Message+@'"}';
	pliv_request = http_request("https://api.plivo.com/v1/Account/"+global.Auth+"/Message/","POST",global.plivo_map,_msg_data);
	
}

/// @function plivo_call(From, To, URL);
/// @param {string} From The number to send the message from
/// @param {string} To The number to send the message to
/// @param {string} URL The XML file to use

function plivo_call(_From, _To, _URL)
{
	
	//Places a call from a Plivo number (owned by you) to the specified number, reading instructions from a specified XML file
	
	 _call_data = @'{"to": "'+ _To +@'","from": "'+ _From +@'", "answer_url": "'+ _URL +@'", "answer_method": "GET"}';
	pliv_request = http_request("https://api.plivo.com/v1/Account/"+global.Auth+"/Call/","POST",global.plivo_map,_call_data);
	
}

/// @function plivo_debug();

function plivo_debug()
{
	
	//Place this in the Async - HTTP event of the object calling plivo_call or plivo_text to display debug info.

	if (ds_map_find_value(async_load, "id") == pliv_request)
	{
		if (ds_map_find_value(async_load, "status") == 0)
		{
			r_str = ds_map_find_value(async_load, "result");
		}
		else
		{
			r_str = "null";
		}
	}
   
	if (r_str != "null")
	{
		show_message_async(r_str);
	}
}