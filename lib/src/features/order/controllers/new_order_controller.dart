import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../../authentication/screens/home.dart';

class OrderCreationController extends GetxController {
  static OrderCreationController get find => Get.find();
  Rx<bool> isLoading=false.obs;
  void tryPost(
    String customer,
    String date,
    String deliveryDate,
    String po,
    String description,
    List elastics,
  ) async {
    isLoading.value=true;
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/order/create-order',
      data: {
        'customer': customer,
        'date': date.toString(),
        'elasticOrdered': elastics,
        'supplyDate': deliveryDate,
        'po': po,
        'description': description
      },
    );

    if (response.statusCode == 201) {
      isLoading.value=false;
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          showProgressIndicator: true,
          message: 'Order Added Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Get.to(const Home());
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }
}
