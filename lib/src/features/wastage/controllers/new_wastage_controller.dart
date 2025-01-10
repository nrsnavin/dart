import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../../authentication/screens/home.dart';
import '../models/wastageBrief.dart';
import '../models/wastageSummary.dart';

class WastageController extends GetxController {
  static WastageController get find => Get.find();

  RxList<WastageBrief> wastageBriefs = (List<WastageBrief>.of([])).obs;
  RxList<WastageSummary> wastageSum =
      (List<WastageSummary>.of([])).obs;


  void getWastageDetailsInRange(String start, String end) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/wastage/get-in-range?start=$start&less=$end");
    final response =
    await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['array']
        .map<WastageBrief>((e) => WastageBrief.fromJson(e))
        .toList();

    wastageBriefs.value = x;
  }


  void tryPost(
      String elastic,
      String job,
      String employee,
      int quantity,
      String reason,

 ) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/wastage/add-wastage',
      data: {
        'job': job,
        'employee': employee,
        'elastic': elastic,
        'reason': reason,
        'quantity': quantity,

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



  void getWastageDetailsInDate(String date) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/wastage/get-in-date?date=$date");
    final response =
    await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['wastage']
        .map<WastageSummary>((e) => WastageSummary.fromJson(e))
        .toList();

    wastageSum.value = x;
  }


}
