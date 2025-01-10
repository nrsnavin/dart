import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../../authentication/screens/home.dart';
import '../../customers/models/customer.dart';
import '../models/rawMaterial.dart';

class ElasticCreationController extends GetxController {
  static ElasticCreationController get find => Get.find();
  Rx<bool> isLoading = false.obs;

  Rx<bool> isLoadingNew = false.obs;

  RxList rubberList = [].obs;
  RxList warpList = [].obs;
  RxList weftList = [].obs;
  RxList coveringList = [].obs;

  void tryPost(
      String name,

      Map rubber,
      Map weft,
      Map covering,
      String rubberEnds,
      int noOfWarps,
      List selectedWarps,
      String pick,
      String designHooks,
      String weight,
      String elongation,
      String recovery,
      String strech,
      String width,
      String image,
      String drawType) async {
    isLoadingNew.value = true;
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/elastic/create-elastic',
      data: {
        'warpSpandex': rubber,
        'name': name,
        'warpYarn': selectedWarps,
        'spandexCovering': covering,
        'pick': pick,
        'spandexEnds': rubberEnds,
        'weftYarn': weft,
        'noOfHook': designHooks,
        'weight': weight,
        'elongation': elongation,
        'recovery': recovery,
        'strech': strech,
        'width': width,
        'image': image,
        'drawType': drawType
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Elastic added Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );

      Get.to(Home());
      isLoading.value = false;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }

  void getDataForNewElastic() async {
    isLoading.value = true;
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/rawMaterial/materialForNewElastic");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
// print(body);
      rubberList.value =
          (body["rubber"].map((e) => RawMaterial.fromJson(e))).toList();
      warpList.value =
          (body["warp"].map((e) => RawMaterial.fromJson(e))).toList();
      weftList.value =
          (body["weft"].map((e) => RawMaterial.fromJson(e))).toList();
      coveringList.value =
          (body["covering"].map((e) => RawMaterial.fromJson(e))).toList();

      isLoading.value = false;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to to fetch Data.');
    }
  }
}
