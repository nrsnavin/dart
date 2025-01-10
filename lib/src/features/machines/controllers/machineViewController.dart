import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../models/machine.dart';

class MachineViewController extends GetxController {
  static MachineViewController get find => Get.find();

  RxList<MachineList> machinesList = (List<MachineList>.of([])).obs;

  Rx<bool> isLoading=false.obs;

  void getMachines() async {

    isLoading.value=true;
    var url = Uri.parse("http://13.53.134.184:2701/api/v2/machine/get-machines");
    final response =
    await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['machines']
        .map<MachineList>((e) => MachineList.fromJson(e))
        .toList();

    isLoading.value=false;

    machinesList.value = x;
  }
}
