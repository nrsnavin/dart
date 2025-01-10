import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/productionBrief.dart';
import '../models/productionDetail.dart';
import '../models/productionSummary.dart';

class ProductionViewController extends GetxController {
  RxList<ProductionBrief> productionBriefs = (List<ProductionBrief>.of([])).obs;
  RxList<ProductionSummary> productionSum =
      (List<ProductionSummary>.of([])).obs;

  Rx<bool> isLoading=false.obs;

  Rx<ProductionDetail> prodDetail = ProductionDetail(
          elastics: [],
          machineManufacturer: "",
          shift: "",
          employee: "",
          orderNo: "",
          machine: "",
          production: 0,
          date: "",
          noOfHeads: 0,
          id: "")
      .obs;

  static ProductionViewController get find => Get.find();

  void getProductionDetailsInRange(String start, String end) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/production/get-in-range?start=$start&less=$end");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['array']
        .map<ProductionBrief>((e) => ProductionBrief.fromJson(e))
        .toList();

    productionBriefs.value = x;
  }

  void getProductionDetailsInDate(String date) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/production/get-in-date?date=$date");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['production']
        .map<ProductionSummary>((e) => ProductionSummary.fromJson(e))
        .toList();

    productionSum.value = x;
  }

  void getProductionDetail(String id) async {

    isLoading.value=true;
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/production/get-productionDetail?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);


    var x = ProductionDetail.fromJson(body['data']);
    isLoading.value=false;
    prodDetail.value = x;
  }
}
