import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common _widgets/appBar.dart';
import '../../elastics/models/elastic.dart';
import '../controllers/productionViewController.dart';
import '../models/productionSummary.dart';
import 'productionDetail.dart';

class ViewProductionOnDate extends StatefulWidget {
  const ViewProductionOnDate({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewProductionOnDate();
  }
}

class _ViewProductionOnDate extends State<ViewProductionOnDate> {
  final productionViewController = Get.put(ProductionViewController());

  late List<ProductionSummary> postsFuture =
      productionViewController.productionSum;

  @override
  void initState() {
    productionViewController.getProductionDetailsInDate(args[0]);
    super.initState();
  }

  var args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: NAppBar(showBackArrow: true,),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Selected Date: ' + args[0],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: Center(
                          // FutureBuilder
                          child: postsFuture.isNotEmpty
                              ? buildPosts(postsFuture!)
                              : const Text("Loading"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
    throw UnimplementedError();
  }

  Widget buildPosts(List<ProductionSummary> p) {
    return ListView.builder(
      itemCount: p.length,
      itemBuilder: (context, index) {
        final order = p[index];
        return InkWell(
          onDoubleTap: () => {
            Get.to(() =>  ProductiondetailScreen(), arguments: [order.id])
          },
          child: Container(
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            width: double.maxFinite,
            child: Column(
              children: [

                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Total Production:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Text(
                      order.production.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Machine-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.machine,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Employee-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.employee,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Shift-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.shift,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Order Number-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.orderNo,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// function to display fetched data on screen
