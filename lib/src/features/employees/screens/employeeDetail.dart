import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../common _widgets/appBar.dart';
import '../../job/controllers/new_job_controller.dart';
import '../../production/screens/productionDetail.dart';
import '../controllers/employeesController.dart';
import '../models/employeeDetailModel.dart';

class EmployeedetailScreen extends StatefulWidget {
  const EmployeedetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmployeedetailScreen();
  }
}

class _EmployeedetailScreen extends State<EmployeedetailScreen> {
  final empController = Get.put(EmployeeController());

  var args = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    empController.getEmployeeDetail(args[0]);
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
        Obx(() => empController.isLoadingDetail.value
            ? const SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
              )
            : buildWidget(empController.employeeDetail.value, context))
      ])),
    );
  }
}

Widget buildWidget(EmployeeDetailModel eDetail, BuildContext context) {
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
                          "Name-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          eDetail.name.toString()),
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
                          "Aadhar UIDAI-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          eDetail.aadhar.toString()),
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
                          "Department-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          eDetail.department.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          "Skill-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          eDetail.skill.toString()),
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
                          "Performance-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          eDetail.performance.toString()),
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
                          "Total Production-"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          eDetail.totalProduction.toString()),
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
                          "Wastage in Total "),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          eDetail.totalWastage.toString()),
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
                          "Average Production- "),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          (eDetail.totalProduction / eDetail.totalShifts)
                              .toStringAsFixed(0)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Wastage details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width - 100,
                    child: DataTable(columns: const [
                      DataColumn(
                        label: Text('Date'),
                      ),
                      DataColumn(
                        label: Text('Quantity'),
                      ),
                      DataColumn(
                        label: Text('Reason'),
                      ),
                    ], rows: [
                      for (int i = 0; i < eDetail.wastages.length; i++)
                        DataRow(cells: [
                          DataCell(Text(DateFormat("dd-MM-yyyy").format(
                              DateTime.parse(
                                  eDetail.wastages[i]['createdAt'])))),
                          DataCell(
                              Text(eDetail.wastages[i]['quantity'].toString())),
                          DataCell(Text(eDetail.wastages[i]['reason'])),
                        ])
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Production details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.sizeOf(context).width - 50,
                    child: DataTable(columns: const [
                      DataColumn(
                        label: Text('Date'),
                      ),
                      DataColumn(
                        label: Text('Production'),
                      ),
                      DataColumn(
                        label: Text('Shift'),
                      ),
                      DataColumn(
                        label: Text('Detail'),
                      ),
                    ], rows: [
                      for (int i = 0; i < eDetail.shifts.length; i++)
                        DataRow(cells: [
                          DataCell(Text(DateFormat("dd-MM").format(
                              DateTime.parse(eDetail.shifts[i]['date'])))),
                          DataCell(
                              Text(eDetail.shifts[i]['production'].toString())),
                          DataCell(Text(eDetail.shifts[i]['shift'])),
                          DataCell(TextButton(

                            onPressed: () {
                              Get.to(ProductiondetailScreen(),
                                  arguments: [eDetail.shifts[i]['_id']]);
                            },
                            child: Text("View Details", style: TextStyle(fontSize: 10),),
                          )),
                        ])
                    ]),
                  ),
                  const SizedBox(
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
