import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common _widgets/appBar.dart';
import '../../elastics/screens/elasticDetailScreen.dart';
import '../controllers/shift_controller.dart';
import '../models/shiftDetailModel.dart';

class ShiftDetailScreen extends StatefulWidget {
  const ShiftDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShiftDetailScreen();
  }
}

class _ShiftDetailScreen extends State<ShiftDetailScreen> {
  final shiftController = Get.put(ShiftController());

  var args = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    shiftController.getOpenShiftDetail(args[0]);

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
          Obx(() => shiftController.isLoading.value
              ? const SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 50.0,
                )
              : buildWidget(shiftController.shiftDetail.value, context))
        ])),
      ),
    );
  }
}

Widget buildWidget(ShiftDetailModel sDetail, BuildContext context) {
  final shiftController = Get.put(ShiftController());
  final feedbackController = TextEditingController();
  final productionController = TextEditingController();
  return Container(
    margin: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Date-"),
                  Text(
                    style: const TextStyle(fontSize: 18),
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(sDetail.date)),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Employee-"),
                  Text(
                      style: const TextStyle(fontSize: 18),
                      sDetail.employee.toString()),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Machine-"),
                  Text(
                      style: const TextStyle(fontSize: 18),
                      sDetail.machine.toString()),
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
                      "Shift-"),
                  Text(style: const TextStyle(fontSize: 18), sDetail.shift)
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
                      "Job-"),
                  Text(style: const TextStyle(fontSize: 18), sDetail.jobNo)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Production-"),
                  Text(
                      style: const TextStyle(fontSize: 18),
                      sDetail.production.toString())
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      "Description-"),
                  Text(
                      style: const TextStyle(fontSize: 18), sDetail.description)
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
            "Elastics Running"),
        for (int i = 0; i < sDetail.elastics.length; i++)
          Container(
            decoration: BoxDecoration(color: Colors.grey),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text((i + 1).toString() + ".)"),
                  Text(sDetail.elastics[i]['name']),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 10,
                  ),
                  TextButton(
                      onPressed: () => Get.to(ElasticDetailScreen(),
                          arguments: [sDetail.elastics[i]['id']]),
                      child: Text("View Details"))
                ],
              ),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              if(sDetail.status=="open")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            enableFeedback: true,
                            backgroundColor: Colors.black,
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (
                                BuildContext context,
                                ) {
                              return Container(
                                height: MediaQuery.sizeOf(context).height,
                                color: Colors.amber,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text(
                                      'Enter Production',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: TextFormField(
                                        controller: productionController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            labelText: "Production",
                                            hintText:
                                            "Enter Production in Meters",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2)))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      child: TextFormField(
                                        controller: feedbackController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "FeedBack",
                                            hintText: "Enter Feedback ",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2)))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    ElevatedButton(
                                      child: const Text("Enter Production"),
                                      onPressed: () => {
                                        shiftController.tryProductionEntry(
                                            int.parse(
                                                productionController.value.text),
                                            feedbackController.value.text,
                                            sDetail.id)
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                            style: TextStyle(color: Colors.white),
                            "Add Production"))
                  ],
                ),
            ],
          ),
        )
      ],
    ),
  );
}
