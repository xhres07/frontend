import 'dart:convert';
import 'dart:io';
import 'package:aqua_store/model/add_product_model.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<dynamic> putproduct(
  String name,
  String category,
  String description,
  String availableVehicle,
  String price,
  String image,
  String id,
  context,
) async {
  var body = {
    "name": name,
    "category": category,
    "description": description,
    "countInStock": availableVehicle,
    "price": price,
    "image": image,
  };
  String? token = await SharedServices.loginDetails();
  var response = await http.put(
    Uri.parse(Configs.product + "/" + id),
    headers: {
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Origin": "/",
      "Content-Type": "application/json",
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    var addProduct = addProductFromJson(response.body);
    return addProduct;
  } else {
    Fluttertoast.showToast(
      msg: "Error ! \nPlease try again later.",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.red[800],
    );
  }
}
