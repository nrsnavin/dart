import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../authentication/screens/home.dart';


class CustomerCreationController extends GetxController {
  static CustomerCreationController get find => Get.find();

  void tryPost(
      String name,
      String email,
      String gstin,
      String contactName,
      String contactNumber,
      String paymentTerms,
 ) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/customer/create-customer',
      data: {
        'email': email,
        'name': name,
        'gstin': gstin,
        'contactName': contactName,
        'phoneNumber': contactNumber,
        // 'purchase': purchase,
        // 'accountant': accounts,
        // 'merchandiser': merchandiser,
        'paymentTerms': paymentTerms
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.to(Home());
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }
}
