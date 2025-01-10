import 'dart:convert';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/elastic.dart';
import '../models/elasticDetail.dart';


class ElasticListController extends GetxController {
  static ElasticListController get find => Get.find();
  Rx<bool> isLoading = false.obs;
  Rx<bool> isDetailLoading = false.obs;
  RxList<Elastic> elasticList = (List<Elastic>.of([])).obs;

  Rx<ElasticDetail> elasticDetail = ElasticDetail(
          name: "test ",
          weight: "t",
          warpYarns: [
            {"name": "test", "ends": "143", "type": "base"}
          ],
          drawType: "8",
          weft: "tets",
          rubber: "test",
          covering: "test",
          hooks: "140",
          pick: "23",
          rubberEnds: 23,
          stock: 100,
          quantitySold: 12,
          id: "q",
          elongation: "129",
          costing: "",
          order: "12",
          recovery: "90",
          strech: "24")
      .obs;

  void getElastics() async {
    isLoading.value = true;
    var url =
        Uri.parse("http://13.53.134.184:2701/api/v2/elastic/get-elastics");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = body['elastics'].map<Elastic>((e) => Elastic.fromJson(e)).toList();
    isLoading.value = false;

    elasticList.value = x;
  }

  void getElasticDetail(String id) async {
    isDetailLoading.value = true;
    var url = Uri.parse(
        "http://13.53.134.184:2701/api/v2/elastic/getElasticDetail?id=$id");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> body = json.decode(response.body);

    var x = ElasticDetail.fromJson(body['elastic']);
    elasticDetail.value = x;
    isDetailLoading.value = false;
  }
}
