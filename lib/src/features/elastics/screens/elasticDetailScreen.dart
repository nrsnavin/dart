import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';


import '../../../common _widgets/appBar.dart';
import '../controllers/elastic_list_controller.dart';
import '../models/elastic.dart';
import '../models/elasticDetail.dart';

class ElasticDetailScreen extends StatefulWidget {
  const ElasticDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ElasticDetailScreen();
  }
}

class _ElasticDetailScreen extends State<ElasticDetailScreen> {
  final elasticListController = Get.put(ElasticListController());

  var args = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    elasticListController.getElasticDetail(args[0]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        NAppBar(
          showBackArrow: true,
        ),
        Obx(() =>
        elasticListController.isDetailLoading.value?const SpinKitRotatingCircle(
          color: Colors.blue,
          size: 100.0,
        ):
            buildWidget(elasticListController.elasticDetail.value, context))
      ])),
    );
  }
}

Widget buildWidget(ElasticDetail eDetail, BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Image(
                semanticLabel: eDetail.name,
                width: MediaQuery.sizeOf(context).width / 4,
                image: NetworkImage(eDetail.image)),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    eDetail.name),
                Row(
                  children: [
                    const Text(
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        "Weft:"),
                    Text(
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        eDetail.weft),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        "Rubber:"),
                    Text(
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        eDetail.rubber),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        "Covering:"),
                    Text(
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        eDetail.covering),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        "DrawingType:"),
                    Text(
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        eDetail.drawType),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        "Quantity Produced:"),
                    Text(
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        eDetail.quantitySold.toString() + " Mtrs"),
                  ],
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Stock-"),
                  Text(
                      style: const TextStyle(fontSize: 18),
                      eDetail.stock.toString() + " Mtrs")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Running Orders-"),
                  Text(
                      style: const TextStyle(fontSize: 18),
                      eDetail.order == null ? "None" : eDetail.order!)
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            "Warp Yarns"),
        DataTable(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1),
                    left: BorderSide(width: 1),
                    right: BorderSide(width: 1),
                    top: BorderSide(width: 1))),
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Ends',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Type',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: eDetail.warpYarns
                .map((x) => DataRow(cells: [
                      DataCell(Text(x['name']!)),
                      DataCell(Text(x['ends']!)),
                      DataCell( Text(x['type']!)),
                    ]))
                .toList()),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Rubber Ends-"),
                  Text(style: const TextStyle(fontSize: 18), eDetail.rubberEnds.toString())
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Pick-"),
                  Text(style: const TextStyle(fontSize: 18), eDetail.pick)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Design Hooks-"),
                  Text(style: const TextStyle(fontSize: 18), eDetail.hooks)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Weight-"),
                  Text(
                      style: const TextStyle(fontSize: 18),
                      eDetail.weight + " Grams")
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Elongation-"),
                  Text(
                      style: const TextStyle(fontSize: 18),
                      eDetail.elongation + "%")
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Recovery-"),
                  Text(
                      style: const TextStyle(fontSize: 18),
                      eDetail.recovery + "%")
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Strech-"),
                  Text(style: const TextStyle(fontSize: 18), eDetail.strech)
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          enableFeedback: true,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      onPressed: () {},
                      child: const Text(
                          style: TextStyle(color: Colors.white), "New Order")),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          enableFeedback: true,
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      onPressed: () {},
                      child: const Text(
                          style: TextStyle(color: Colors.white),
                          "Add Delivery Chaalan"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {}, child: const Text("Edit Details")),
                  TextButton(onPressed: () {}, child: const Text("Delete Item"))
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
