import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../../authentication/screens/home.dart';
import '../models/material.dart';

class RawMaterialCreationController extends GetxController {
  static RawMaterialCreationController get find => Get.find();
  RxList<MaterialModel> rubbersMaterial = (List<MaterialModel>.of([])).obs;
  RxList<MaterialModel> weftsMaterial = (List<MaterialModel>.of([])).obs;

  RxList<MaterialModel> warpsMaterials = (List<MaterialModel>.of([])).obs;
  RxList<MaterialModel> coveringsMaterial = (List<MaterialModel>.of([])).obs;

  RxList<MaterialModel> materials = (List<MaterialModel>.of([])).obs;

  void tryPost(
    String name,
    String initialStock,
    String type,
    String price,
    String supplier,
  ) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/rawMaterial/create-material',
      data: {
        'name': name,
        'stock': initialStock,
        'category': type,
        'price': price,
        'supplier': supplier,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Raw Material  Added Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Get.to(Home());
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }

  void tryPostMaterialInward(
      String date, String po, String ref, List materialsData) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/rawMaterial/material-Inward',
      data: {
        'date': date,
        'po': po,
        'reference': ref,
        'materials': materialsData,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Raw Material Inward added Successfully',
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

  void getRubbers() async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/rawMaterial/get-rubbers");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['rubbers']
        .map<MaterialModel>((e) => MaterialModel.fromJson(e))
        .toList();

    rubbersMaterial.value = x;
  }

  void getCoverings() async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/rawMaterial/get-coverings");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['coverings']
        .map<MaterialModel>((e) => MaterialModel.fromJson(e))
        .toList();

    coveringsMaterial.value = x;
  }

  void getWarps() async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/rawMaterial/get-warpYarns");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['yarns']
        .map<MaterialModel>((e) => MaterialModel.fromJson(e))
        .toList();

    warpsMaterials.value = x;
  }

  void getWefts() async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/rawMaterial/get-wefts");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['wefts']
        .map<MaterialModel>((e) => MaterialModel.fromJson(e))
        .toList();

    weftsMaterial.value = x;
  }

  void getMaterials() async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/rawMaterial/materials");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['materials']
        .map<MaterialModel>((e) => MaterialModel.fromJson(e))
        .toList();

    materials.value = x;
  }
}
