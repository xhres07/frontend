import 'dart:convert';
import 'package:aqua_store/model/renting_model.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

List<RequestAttendance>? _check = [];
List<RequestAttendance>? get value => _check;

Future<dynamic> rentProduct(
    String address,
    String city,
    String postalCode,
    String country,
    context,
    {List? data}) async {
  var body = {
    "orderItems": [
      for (var a in data!)
        {
          "name": "${a.name}",
          "qty": 1,
          "image": "/images/sample.jpg",
          "price": "${a.productPrice}",
          "product": "${a.id}"
        }
    ],
    "shippingAddress": {
      "address": "$address",
      "city": "$city",
      "postalCode": "$postalCode",
      "country": "$postalCode"
    }
  };
  String? token = await SharedServices.loginDetails();
  var response = await http.post(
    Uri.parse(Configs.adminOrder),
    headers: {
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Origin": "/",
      "Content-Type": "application/json",
    },
    body: json.encode(body),
  );
  if (response.statusCode == 201) {
    var modelProduct = requestAttendanceFromJson(response.body);
    Fluttertoast.showToast(
      msg: "Successfully Bought",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.redAccent[700],
    );
    return modelProduct;
  } else {
    Fluttertoast.showToast(
      msg: "Error ! \nPlease try again later.",
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 20.0,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.redAccent[700],
    );
  }
}
