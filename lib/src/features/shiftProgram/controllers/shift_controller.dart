import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../../job/controllers/new_job_controller.dart';
import '../../job/screens/jobDetailScreen.dart';
import '../models/employee.dart';
import '../models/shiftDetailModel.dart';
import '../models/shiftOpenListModel.dart';

class ShiftController extends GetxController {
  static ShiftController get find => Get.find();
  RxList<Employee> employeesWeave = (List<Employee>.of([])).obs;
  RxList<ShiftOpenListModel> shiftsOpen = (List<ShiftOpenListModel>.of([])).obs;


  Rx<bool> isLoadingPentry=false.obs;

  Rx<bool> isLoading=false.obs;

  Rx<ShiftDetailModel> shiftDetail = ShiftDetailModel(
          elastics: [],
          customer: "test",
          description: "open",
          jobNo: "test",
          shift: "12",
          date: DateTime.now().toString(),
          id: "test",
          employee: "",
          status: "",
          production: 0,
          machine: "",
          noOfHooks: 190,
          noOfHeads: 7)
      .obs;

  void tryPost(
    String jobId,
    DateTime date,
    String shift,
    String description,
    String employee,
  ) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/shift/create-shift',
      data: {
        'job': jobId,
        'date': date.toString(),
        'shift': shift,
        'description': description,
        'employee': employee
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      final jobOrderListController = Get.put(JobCreationController());
      jobOrderListController.getJobOrderDetail(jobId);
     Get.off(JobOrderDetailScreen(),arguments: [jobId]);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }

  void getWeavingEmployees() async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/employee/get-employee-weave");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x =
        body['employees'].map<Employee>((e) => Employee.fromJson(e)).toList();

    employeesWeave.value = x;
  }

  void getOpenShifts() async {
    var url = Uri.parse("http://13.53.134.184:2701/api/v2/shift/all-open-shifts");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['shifts']
        .map<ShiftOpenListModel>((e) => ShiftOpenListModel.fromJson(e))
        .toList();

    shiftsOpen.value = x;
  }

  void getOpenShiftDetail(String id) async {
    isLoading.value=true;
    var url = Uri.parse("http://13.53.134.184:2701/api/v2/shift/shiftDetail?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

     shiftDetail.value = ShiftDetailModel.fromJson(body['data']);

     isLoading.value=false;
    // shiftsOpen.value = x;
  }


  void tryProductionEntry(int production, String feedBack,String id) async {


    isLoadingPentry.value=true;
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/shift/enter-shift-production',
      data: {'production': production, 'feedback': feedBack,'id':id},
    );

    if (response.statusCode == 201) {
      isLoadingPentry.value=false;
      getOpenShiftDetail(id);
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Production Added Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );






    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }
}
