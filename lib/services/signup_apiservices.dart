import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:aqua_store/model/error_model.dart';
import 'package:aqua_store/model/sign_up_model.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<dynamic> signUpCustomer(
  String name,
  String email,
  String password,
) async {
  late SignUp model;
  var body = {
    "name": name,
    "email": email,
    "password": password,
  };
  var response = await http.post(
    Uri.parse(Configs.signUp),
    body: jsonEncode(body),
    headers: {
      "Access-Control-Allow-Origin": "/",
      "Content-Type": "application/json",
    },
  );
  if (response.statusCode == 201) {
    model = signUpFromJson(response.body);
    return model;
  } else {
    return Fluttertoast.showToast(
      msg: "Error ! \nPlease Try Again Later.",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.red[800],
    );
  }
}
