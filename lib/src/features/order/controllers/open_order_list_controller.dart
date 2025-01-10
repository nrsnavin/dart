import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


import '../models/order.dart';
import '../models/orderDetail.dart';

class OpenOrderListController extends GetxController {
  static OpenOrderListController get find => Get.find();

  RxList<Order> openOrderList = (List<Order>.of([])).obs;
  Rx<bool> isLoading = false.obs;
  RxList<Order> pendingOrder = (List<Order>.of([])).obs;

  Rx<OrderDetail> orderDetail = OrderDetail(
    jobs: [],
    elastics: [],
    customer: "test",
    status: "open",
    po: "test",
    orderNo: "12",
    desc: "test",
    delDate: DateTime.now(),
    date: DateTime.now(),
    id: "test",
    rawmaterialRequired: [],
  ).obs;

  void getOpenOrders() async {
    Get.showSnackbar(
      GetSnackBar(
        title: "Processing Data",
        icon: const Icon(Icons.refresh),
        duration: const Duration(seconds: 3),
        isDismissible: true,
      ),
    );
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/order/get-open-orders");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['openOrders'].map<Order>((e) => Order.fromJson(e)).toList();

    openOrderList.value = x;
  }

  void getPendingOrders() async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/order/get-pending-orders");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['pending'].map<Order>((e) => Order.fromJson(e)).toList();

    pendingOrder.value = x;
  }

  void getOrderDetail(String id) async {
    isLoading.value = true;
    try {
      var url = Uri.parse(
          "http://13.53.134.184:2701/api/v2/order/get-orderDetail?id=$id");
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      final Map<String, dynamic> body = json.decode(response.body);

      var x = OrderDetail.fromJson(body['data']);
      orderDetail.value = x;
    } finally {
      isLoading.value = false;
    }
  }

  void getOrderApproval(String id) async {
    var url = Uri.parse("http://"
        "13.53.134.184:2701/api/v2/order/order-approval?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    getOrderDetail(body['order']['_id']);
    Get.showSnackbar(
      const GetSnackBar(
        title: "Success",
        message: 'Order Approved',
        icon: Icon(Icons.refresh),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ),
    );
  }

  void getOrderClosed(String id) async {
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/order/order-closed?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    getOrderDetail(id);
  }

  void getRawMaterialRequired(String id) async {
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/order/checkMaterialRequired?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    getOrderDetail(id);
    Get.showSnackbar(
      const GetSnackBar(
        title: "Success",
        message: 'Raw Material Reequired Feteched',
        icon: Icon(Icons.refresh),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ),
    );
  }
}
