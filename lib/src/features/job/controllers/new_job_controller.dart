import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart';


import '../../authentication/screens/home.dart';
import '../../shiftProgram/models/employee.dart';
import '../models/JobBrief.dart';
import '../models/JobOrderDetail.dart';
import '../models/Machine.dart';
import '../models/Warping.dart';

class JobCreationController extends GetxController {
  static JobCreationController get find => Get.find();

  RxList<Employee> employeesCheck = (List<Employee>.of([])).obs;

  RxList<JobBrief> runningJobList = (List<JobBrief>.of([])).obs;

  Rx<JobOrderDetail> jobOrderDetail = JobOrderDetail(
          elastics: [],
          customer: "test",
          status: "open",
          order: "test",
          jobOrderNo: "12",
          date: DateTime.now(),
          id: "test",
          shiftDetails: [],
          warping: {},
          covering: {},
          machine: {},
          checking: "")
      .obs;
  RxList<Machine> machinesList = (List<Machine>.of([
    Machine(
        noOfHooks: 198,
        noOfHead: 6,
        manufacturer: "Muller",
        ID: "tetst",
        id: "test",
        dateOfPurchase: "299")
  ])).obs;
  Rx<WarpingDetail> warpingDetail = WarpingDetail(
          status: "test",
          id: "nu",
          date: DateTime.now(),
          elastics: [],
          job: '',
          closedBy: '',
          completedDate: DateTime.now())
      .obs;

  Rx<WarpingDetail> coveringDetail = WarpingDetail(
          status: "test",
          id: "nu",
          date: DateTime.now(),
          elastics: [],
          job: '',
          closedBy: '',
          completedDate: DateTime.now())
      .obs;

  Rx<bool> isLoading = false.obs;

  Rx<bool> isLoadingCreateJob = false.obs;

  Rx<bool> isLoadingDetail = false.obs;

  Rx<bool> isLoadingInventory = false.obs;

  Rx<bool> isLoadingRunning = false.obs;

  Rx<bool> isLoadingWarpCompleted = false.obs;

  Rx<bool> isLoadingCoverCompleted = false.obs;

  void tryPost(
    String order,
    String date,
    String status,
    List elastics,
    String customer,
  ) async {
    isLoadingCreateJob.value = true;
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/job/create-job',
      data: {
        'customer': customer,
        'date': date.toString(),
        'elastics': elastics,
        'status': status,
        'order': order,
      },
    );

    if (response.statusCode == 201) {
      isLoadingCreateJob.value = false;
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      Get.offAll(Home());
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Job Added Successfully',
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

  void getJobOrderDetail(String id) async {
    isLoadingDetail.value = true;

    try {
      var url = Uri.parse(
          "http://13.53.134.184:2701/api/v2/job/get-jobOrderDetail?id=$id");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      final Map<String, dynamic> body = json.decode(response.body);

      var x = JobOrderDetail.fromJson(body['jobOrder']);
      isLoadingDetail.value = false;
      jobOrderDetail.value = x;
    } finally {
      isLoadingDetail.value = false;
    }
  }

  void getJobInventoryApproval(String id) async {
    isLoadingInventory.value = true;
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/approveInventory?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);
    isLoadingInventory.value = false;
    getJobOrderDetail(id);
  }

  void getWarpingDetail(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/get-warpingDetails?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = WarpingDetail.fromJson(body['warp']);
    warpingDetail.value = x;
  }

  void getRunningJobs() async {
    isLoadingRunning.value = true;
    var url = Uri.parse("http://13.53.134.184:2701/api/v2/job/runningJobs");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['jobs'].map<JobBrief>((e) => JobBrief.fromJson(e)).toList();

    runningJobList.value = x;

    isLoadingRunning.value = false;
  }

  void getWarpingCompleted(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/get-warpingCompleted?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = WarpingDetail.fromJson(body['warp']);
    warpingDetail.value = x;

    Get.offAll(Home());
  }

  void tryWarpingEntry(String id, String closedBy) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/warping/warping-completed',
      data: {'id': id, 'closedBy': closedBy},
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Marked Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Get.to((Home()));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }

  void tryCoveringEntry(String id, String closedBy) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/covering/covering-completed',
      data: {'id': id, 'closedBy': closedBy},
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Marked Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Get.to((Home()));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }

  void getCoveringCompleted(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/get-coveringCompleted?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = WarpingDetail.fromJson(body['covering']);
    coveringDetail.value = x;

    Get.offAll(Home());
  }

  void getCheckingCompleted(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/get-markCheckingCompleted?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    getJobOrderDetail(id);

    Get.offAll(Home());
  }

  void getPackingCompleted(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/get-markPackingCompleted?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    Get.to(Home());
  }

  void getCoveringDetail(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/get-coveringDetail?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = WarpingDetail.fromJson(body['covering']);

    coveringDetail.value = x;
  }

  void getMachines() async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/machine/get-machines");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['machines'].map<Machine>((e) => Machine.fromJson(e)).toList();
    machinesList.value = x;
  }

  void getCheckingEmployees() async {
    isLoading.value = true;
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/employee/get-employee-checking");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x =
        body['employees'].map<Employee>((e) => Employee.fromJson(e)).toList();

    employeesCheck.value = x;
    isLoading.value = false;
  }

  void getWeavingCompleted(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/get-markWeavingCompleted?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    getJobOrderDetail(id);
  }

  void getFinishingCompleted(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/job/get-markFinishingCompleted?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    getJobOrderDetail(id);
  }

  void tryAddWeavingMachine(
    String jid,
    List elastics,
    String machineId,
  ) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/job/weavingPlan',
      data: {
        'jobId': jid,
        'elastics': elastics,
        'machineId': machineId,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Added Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Get.offAll(Home());
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      throw Exception('Failed to Login.');
    }
  }

  void tryAddChecking(
    String jid,
    String eid,
  ) async {
    final response = await Dio().post(
      'http://13.53.134.184:2701/api/v2/job/checkingAssign',
      data: {
        'jobId': jid,
        'employee': eid,
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Get.showSnackbar(
        const GetSnackBar(
          title: "Success",
          message: 'Checking Assigned Successfully',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );

      Get.offAll(Home());
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }
}
