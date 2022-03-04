import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:aqua_store/model/add_product_model.dart';
import 'package:aqua_store/services/product_service.dart';
import 'package:aqua_store/utils/configs.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:provider/provider.dart';

Future<dynamic> postproduct(
  String name,
  String category,
  String description,
  String availableVehicle,
  String price,
  dynamic image,
  context,
) async {
  dynamic imageFile;
  if (image != null) {
    imageFile = MultipartFile.fromFileSync(
      image.path,
      filename: "${image.path.split("/")[image.path.split("/").length - 1]}",
    );
  }

  var body = {
    "name": name,
    "category": category,
    "description": description,
    "countInStock": availableVehicle,
    "price": price,
    "image": image != null ? "/${imageFile.filename}" : null,
  };
  String? token = await SharedServices.loginDetails();
  var response = await http.post(
    Uri.parse(Configs.product),
    headers: {
      "Authorization": "Bearer $token",
      "Access-Control-Allow-Origin": "/",
      "Content-Type": "application/json",
    },
    body: jsonEncode(body),
  );
  if (response.statusCode == 201) {
    var addProduct = addProductFromJson(response.body);
    await Provider.of<MyProduct>(context, listen: false).getproduct(context);
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
