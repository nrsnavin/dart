import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../models/user.dart';
import '../screens/home.dart';

class LoginController extends GetxController {
  static LoginController get find => Get.find();
  Rx<bool> isLoading = false.obs;
  Rx<User> user = User(id: "1", name: "dummy", role: "admin").obs;

  void tryLogin(String email, String password) async {
    isLoading.value = true;
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/user/login-user',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 201) {

      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      await FlutterSessionJwt.saveToken(response.data['token']);
      Get.offAll((const Home()));
      isLoading.value = false;

      user.value = User(
          id: response.data['id'],
          name: response.data['username'],
          role: response.data['role']);

      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Logged In Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      isLoading.value = false;
      Get.showSnackbar(
        const GetSnackBar(
          title: "Failed",
          message: 'Log In Unsuccessful',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      throw Exception('Failed to Login.');
    }
  }
}
