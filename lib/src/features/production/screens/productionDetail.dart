import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';


import '../../../common _widgets/appBar.dart';
import '../../job/controllers/new_job_controller.dart';
import '../controllers/productionViewController.dart';
import '../models/productionDetail.dart';

class ProductiondetailScreen extends StatefulWidget {
  const ProductiondetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductiondetailScreen();
  }
}

class _ProductiondetailScreen extends State<ProductiondetailScreen> {
  final productionViewController = Get.put(ProductionViewController());

  var args = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    productionViewController.getProductionDetail(args[0]);
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
        Obx(() => productionViewController.isLoading.value
            ? SpinKitRotatingCircle(
                color: Colors.blue,
                size: 50.0,
              )
            : buildWidget(productionViewController.prodDetail.value, context))
      ])),
    );
  }
}

Widget buildWidget(ProductionDetail wDetail, BuildContext context) {
  final jobOrderListController = Get.put(JobCreationController());

  return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Date-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.date.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Employee Name-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.employee.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Machine Id-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.machine.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Machine Manufactuer-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.machineManufacturer.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Shift-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.shift.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Production in Total "),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.production.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "No of Heads"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.noOfHeads.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Elastic details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  for (var i = 0; i < wDetail.elastics.length; i++)
                    Row(
                      children: [
                        Text(
                          (i + 1).toString() + "->",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          wDetail.elastics[i].toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ));
}
