import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> PolicyDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var entityId = prefs.getString('entityid');
  var token = prefs.getString('token');
  print(entityId);
  final url = Uri.parse(
      "https://ima.policyera.in/policyera/api/entity/getListData?entitytype=PCY& parenttype=null& parentid=null& viewmode=card");
  final response = await http.post(url,
      body: {"customerid": "${entityId}"},
      headers: {'Authorization': "Bearer ${token}"});

  List entityList = [];
  if (response.statusCode >= 200 &&
      response.statusCode < 300 &&
      response.body != null) {
    var jsonData = jsonDecode(response.body);
    var jasonone = jsonDecode(jsonData["payload"]);

    var jsontwo = jasonone["entitylist"];
    print(jsontwo[1]["media_id"]);

    return entityList;
  } else {
    return false;
  }
}
