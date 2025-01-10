import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../common _widgets/appBar.dart';
import '../controllers/new_job_controller.dart';
import '../models/Machine.dart';

class CheckingplanScreen extends StatefulWidget {
  const CheckingplanScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CheckingplanScreen();
  }
}

class _CheckingplanScreen extends State<CheckingplanScreen> {
  final jobOrderListController = Get.put(JobCreationController());

  var args = Get.arguments;
  var employee;

  var selectedEmployee;

  @override
  void initState() {
    // TODO: implement initState

    jobOrderListController.getJobOrderDetail(args[0]);
    jobOrderListController.getCheckingEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: NAppBar(
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Obx(() => jobOrderListController.isLoading.value
              ? const SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 100.0,
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text(
                        "Checking Assign",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Job Order Number-",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18),
                          ),
                          Text(
                            jobOrderListController
                                .jobOrderDetail.value.jobOrderNo,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Builder(builder: (context) {
                        return DropdownButtonFormField(
                            value: employee,
                            hint: Text("Select Checking Employee"),
                            items: jobOrderListController.employeesCheck
                                .map<DropdownMenuItem<String>>((p) {
                              return DropdownMenuItem<String>(
                                value: p.id,
                                child: Text(p.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                employee = value;
                              });
                            });
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shadowColor: Colors.black),
                          onPressed: () {
                            jobOrderListController.tryAddChecking(
                              jobOrderListController.jobOrderDetail.value.id,
                              employee,
                            );
                          },
                          child: Text(
                              style: TextStyle(color: Colors.white), "Save"))
                    ],
                  ),
                ))
        ])),
      );
    });
  }
}
