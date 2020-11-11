import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationSevice {
  String _baseUrl = "http://10.0.2.2:3030";

  //Login
  Dio dio = new Dio();
  login(email, password) async {
    try {
      print("Authorized");
      return await dio.post("$_baseUrl/login",
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.response.data);
      Fluttertoast.showToast(
        msg: e.response.data["message"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  //Register
  register(email, password, confirmpassword, firstname, lastname) async {
    try {
      return await dio.post("$_baseUrl/register",
          data: {
            "email": email,
            "password": password,
            "confirmpassword": confirmpassword,
            "firstname": firstname,
            "lastname": lastname
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response.data["success"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
