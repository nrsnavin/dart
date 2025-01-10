import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../common _widgets/appBar.dart';
import '../../job/screens/jobCreationScreen.dart';
import '../../job/screens/jobDetailScreen.dart';
import '../controllers/open_order_list_controller.dart';
import '../models/orderDetail.dart';
import '../widgets/elasticOrderDetail.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderDetailScreen();
  }
}

class _OrderDetailScreen extends State<OrderDetailScreen> {
  final orderListController = Get.put(OpenOrderListController());

  var args = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    orderListController.getOrderDetail(args[0]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
          NAppBar(
            showBackArrow: true,
          ),
          Obx(() => buildWidget(orderListController.orderDetail.value,
              orderListController.isLoading.value, context))
        ])),
      ),
    );
  }
}

Widget buildWidget(OrderDetail oDetail, bool isLoading, BuildContext context) {
  return isLoading
      ? CircularProgressIndicator(
          semanticsLabel: 'Circular progress indicator',
        )
      : Container(
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
                              "Order Number:"),
                          Text(
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              oDetail.orderNo!),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              "Order Status:"),
                          Text(
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              oDetail.status!),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              "Customer:"),
                          Text(
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              oDetail.customer!.truncateTo(15)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              "Customer PO:"),
                          Text(
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              oDetail.po!),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              "Ordered Date:"),
                          Text(
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              DateFormat("dd-MM-yyyy").format(oDetail.date!)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              "Expected Delivery Date:"),
                          Text(
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              DateFormat("dd-MM-yyyy")
                                  .format(oDetail.delDate!)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              "Description:"),
                          Text(
                            overflow: TextOverflow.clip,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              oDetail.desc!.truncateTo(20)),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (oDetail.status == "open")
                        approvalBtn(oDetail, context),
                      SizedBox(
                        height: 30,
                      ),
                      if (oDetail.status == "approved")
                        jobCreationBtn(oDetail, context),
                      SizedBox(
                        height: 30,
                      ),
                      if (oDetail.jobs.isNotEmpty)
                        Column(
                          children: [
                            for (int i = 0; i < oDetail.jobs.length; i++)
                              jobDetailBtn(i, oDetail,context),
                          ],
                        )
                      else
                        Text("No Jobs Assigned"),
                      SizedBox(
                        height: 30,
                      ),
                      if (oDetail.rawmaterialRequired.isNotEmpty)
                        materialReq(oDetail, context),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Elastic details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      for (var i = 0; i < oDetail.elastics.length; i++)
                        Elasticorderdetail(i, oDetail.elastics[i])
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

Widget approvalBtn(OrderDetail oDetail, BuildContext context) {
  final orderListController = Get.put(OpenOrderListController());

  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              orderListController.getOrderApproval(oDetail.id!);
              orderListController.getOrderDetail(oDetail.id!);
            },
            child: const Text("Approve Order")),
        SizedBox(
          width: MediaQuery.sizeOf(context).width/100,
        ),
        if (oDetail.rawmaterialRequired.isEmpty)
          (OutlinedButton(
              onPressed: () {
                orderListController.getRawMaterialRequired(oDetail.id!);
                orderListController.getOrderDetail(oDetail.id!);
              },
              child: const Text("Check Raw Materials Required")))
      ],
    ),
  );
}

Widget jobDetailBtn(int i, OrderDetail oDetail,BuildContext context) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Job Order Number-",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
            Text(oDetail.jobs[i]['no'].toString(),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
            SizedBox(
              width: MediaQuery.sizeOf(context).width/8,
            ),
            TextButton(
                onPressed: () {
                  Get.to(JobOrderDetailScreen(),
                      arguments: [oDetail.jobs[i]['id'].toString()]);
                },
                child: Text("View Details"))
          ],
        )
      ],
    ),
  );
}

Widget materialReq(OrderDetail oDetail, BuildContext context) {
  return Container(
    color: Colors.grey,
    padding: EdgeInsets.all(20),
    // decoration: BoxDecoration( ),
    child: Column(
      children: [
        Text(
          "Raw Materials Required",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        for (int i = 0; i < oDetail.rawmaterialRequired.length; i++)
          Column(
            children: [
              (Row(
                children: [
                  Text(
                    oDetail.rawmaterialRequired[i]['name'] + "-",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  Text(
                    "${oDetail.rawmaterialRequired[i]['weight'].toString().truncateTo(4)} Kgs",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.indigo),
                  ),
                ],
              )),
              Row(
                children: [
                  Text("Inhand Stock-"),
                  Text(
                    "${oDetail.rawmaterialRequired[i]['inStock'].toString().truncateTo(6)} Kgs",
                  )
                ],
              )
            ],
          ),
      ],
    ),
  );
}

extension StringExtension on String {
  String truncateTo(int maxLength) =>
      (this.length <= maxLength) ? this : '${this.substring(0, maxLength)}...';
}

Widget jobCreationBtn(OrderDetail oDetail, BuildContext context) {
  final orderListController = Get.put(OpenOrderListController());

  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              Get.to(Jobcreationscreen(), arguments: [oDetail]);
            },
            child: const Text("Assign new Job")),
        OutlinedButton(
            onPressed: () {
              orderListController.getOrderClosed(oDetail.id);
            },
            child: const Text("Mark as Closed")),
      ],
    ),
  );
}
