import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:aqua_store/model/error_model.dart';
import 'package:aqua_store/model/login_model.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<dynamic> login(String email, String password) async {
  late Login model;
  var body = {
    "email": email,
    "password": password,
  };
  var response = await http.post(
    Uri.parse(Configs.login),
    body: jsonEncode(body),
    headers: {
      "Access-Control-Allow-Origin": "/",
      "Content-Type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    model = loginFromJson(response.body);
    return model;
  } else {
    Fluttertoast.showToast(
      msg: "Error ! \nIncorrect Email or Password.",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.red[800],
    );
  }
}
