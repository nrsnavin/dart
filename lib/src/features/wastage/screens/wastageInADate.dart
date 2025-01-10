import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common _widgets/appBar.dart';
import '../controllers/new_wastage_controller.dart';
import '../models/wastageSummary.dart';


class ViewWastageOnDateScreen extends StatefulWidget {
  const ViewWastageOnDateScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewWastageOnDateScreen();
  }
}

class _ViewWastageOnDateScreen extends State<ViewWastageOnDateScreen> {
  final wastageController = Get.put(WastageController());

  late List<WastageSummary> postsFuture =
      wastageController.wastageSum;

  @override
  void initState() {
    wastageController.getWastageDetailsInDate(args[0]);
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

  Widget buildPosts(List<WastageSummary> p) {
    return ListView.builder(
      itemCount: p.length,
      itemBuilder: (context, index) {
        final order = p[index];
        return InkWell(
          onDoubleTap: () => {
            // Get.to(() =>  ProductiondetailScreen(), arguments: [order.id])
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
                      "Wastage In Meters:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Text(
                      order.quantity.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
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
                      "Elastic-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.elastic,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Job-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.job.toString(),
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
