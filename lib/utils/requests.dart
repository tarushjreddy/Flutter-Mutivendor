import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<Map<String, dynamic>> getRequest(String url) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var token = await _prefs.getString('token') ?? '';

  var header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${token}'
  };
  final response = await http.get(Uri.parse(url), headers: header);
  return json.decode(response.body);
}

Future<Map<String, dynamic>> postRequest(
    Map<String, dynamic> data, String url) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var token = _prefs.getString('token') ?? '';

  var header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${token}'
  };
  var response;
  try{
    response =await http.post(Uri.parse(url), headers: header, body: json.encode(data));}
  catch(err){print(err);}
  print(response.body);
  return json.decode(response.body);
}


