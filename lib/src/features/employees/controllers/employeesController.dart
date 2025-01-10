import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../../shiftProgram/models/employee.dart';
import '../models/employeeDetailModel.dart';

class EmployeeController extends GetxController {
  static EmployeeController get find => Get.find();

  Rx<bool> isLoading=false.obs;
  Rx<bool> isLoadingDetail=false.obs;

  RxList<Employee> employeesList = (List<Employee>.of([])).obs;



  Rx<EmployeeDetailModel> employeeDetail = EmployeeDetailModel(
    aadhar: "",
    department: "",
    name: "",
    performance: 0,
    wastages: [],
    role: "",
    shifts: [],
    skill: 0,
    totalWastage: 0,
    totalProduction: 0,
    id: "test",
    totalShifts: 100
  ).obs;


  void getEmployeesList() async {
    isLoading.value=true;
    var url = Uri.parse("http://13.53.134.184:2701/api/v2/employee/get-employees");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x =
        body['employees'].map<Employee>((e) => Employee.fromJson(e)).toList();

    isLoading.value=false;
    employeesList.value = x;
  }

  void getEmployeeDetail(String id) async {
    isLoadingDetail.value=true;
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/employee/get-employee-detail?id=" + id);
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    employeeDetail.value = EmployeeDetailModel.fromJson(body['employee'][0]);

    isLoadingDetail.value=false;
   }
}
