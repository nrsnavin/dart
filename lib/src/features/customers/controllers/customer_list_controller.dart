import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/customer.dart';

class CustomerListController extends GetxController {
  static CustomerListController get find => Get.find();
  Rx<bool> isLoading = false.obs;
  RxList<Customer> customersList = (List<Customer>.of([])).obs;

  void getCustomers() async {
    isLoading.value=true;
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/customer/all-customers");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);



    var x =
        body['customers'].map<Customer>((e) => Customer.fromJson(e)).toList();

    isLoading.value=false;

    customersList.value = x;
  }
}
