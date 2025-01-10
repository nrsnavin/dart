import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../../authentication/screens/home.dart';

class CustomerCreationController extends GetxController {
  static CustomerCreationController get find => Get.find();

  Rx<bool> isLoading = false.obs;


  void tryPost(
      String name,
      String email,
      String gstin,
      String contactName,
      String contactNumber,
      String paymentTerms,
      Object purchase,
      Object accounts,
      Object merchandiser,
      BuildContext context) async {
    isLoading.value = true;
    final response = await Dio().post(
      'http://10.0.2.2:2701/api/v2/customer/create-customer',
      data: {
        'email': email,
        'name': name,
        'gstin': gstin,
        'contactName': contactName,
        'phoneNumber': contactNumber,
        'paymentTerms': paymentTerms,
        'purchase': purchase,
        'accountant': accounts,
        'merchandiser': merchandiser,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      Get.offAll(Home());
      isLoading.value = false;
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Customer Registered Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      isLoading.value = false;
      Get.showSnackbar(
        const GetSnackBar(
          title: "Failed",
          message: 'Registration Unsuccessful',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
  }
}
