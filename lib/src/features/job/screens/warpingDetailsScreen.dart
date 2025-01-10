import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../common _widgets/appBar.dart';
import '../../authentication/controllers/login_controller.dart';
import '../controllers/new_job_controller.dart';
import '../models/Warping.dart';
import '../widgets/warpElasticDetail.dart';

class Warpingdetailsscreen extends StatefulWidget {
  const Warpingdetailsscreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Warpingdetailsscreen();
  }
}

class _Warpingdetailsscreen extends State<Warpingdetailsscreen> {
  final jobOrderListController = Get.put(JobCreationController());

  var args = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    jobOrderListController.getWarpingDetail(args[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        NAppBar(showBackArrow: true,),
        Obx(() =>
            buildWidget(jobOrderListController.warpingDetail.value, context))
      ])),
    );
  }
}

Widget buildWidget(WarpingDetail wDetail, BuildContext context) {
  final loginController = Get.put(LoginController());

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
                          "Status-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.status.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Date Approved"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.date.toString()),
                    ],
                  ),
                  const Text(
                    "Elastic details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  for (var i = 0; i < wDetail.elastics.length; i++)
                    Warpelasticdetail(i, wDetail.elastics[i]),
                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Date Completed"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.completedDate.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Closed By"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          wDetail.closedBy.toString()),
                    ],
                  ),
                  if(wDetail.status=="open")
                    OutlinedButton(
                        onPressed: () {
                          jobOrderListController.tryWarpingEntry(wDetail.id,loginController.user.value.name);
                        }, child: Text("Mark As Completed"))
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
