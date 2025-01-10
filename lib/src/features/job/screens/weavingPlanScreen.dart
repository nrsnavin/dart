import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../common _widgets/appBar.dart';
import '../controllers/new_job_controller.dart';
import '../models/Machine.dart';
import '../widgets/weaveElastic.dart';

class Weavingplanscreen extends StatefulWidget {
  const Weavingplanscreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Weavingplanscreen();
  }
}

class _Weavingplanscreen extends State<Weavingplanscreen> {
  final jobOrderListController = Get.put(JobCreationController());

  var args = Get.arguments;
  var machine;
  var selectedElastics;

  Machine selectedMachine = Machine(
      id: "tets",
      dateOfPurchase: "29001",
      ID: "f",
      manufacturer: "manufacturer",
      noOfHead: 2,
      noOfHooks: 192);

  @override
  void initState() {
    // TODO: implement initState
    selectedElastics = List.filled(selectedMachine.noOfHead, "");
    jobOrderListController.getJobOrderDetail(args[0]);
    jobOrderListController.getMachines();
    super.initState();
  }

  void onTap(int i, String s) {
    selectedElastics[i] = s;
  }

  @override
  Widget build(BuildContext context) {

    List es=jobOrderListController.jobOrderDetail.value.elastics;

    final ids = Set();
    es.retainWhere((x) => ids.add(x['id']));

    selectedElastics = List.filled(selectedMachine.noOfHead, "");
    return Scaffold(
      appBar: NAppBar(showBackArrow: true,),
      body: SingleChildScrollView(
          child: Column(children: [
        Obx(() => Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text("Weaving Planing"),
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
                        jobOrderListController.jobOrderDetail.value.jobOrderNo,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DropdownButtonFormField(
                      value: machine,
                      hint: Text("Select Machine"),
                      items: jobOrderListController.machinesList
                          .map<DropdownMenuItem<String>>((p) {
                        return DropdownMenuItem<String>(
                          value: p.id,
                          child: Text(p.ID.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          int i = jobOrderListController.machinesList
                              .indexWhere((test) => test.id == value);
                          selectedMachine =
                              jobOrderListController.machinesList[i];
                        });
                      }),
                  for (var i = 0; i < selectedMachine.noOfHead; i++)
                    Weaveelastic(i, onTap,
                        es),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shadowColor: Colors.black),
                      onPressed: () {
                        jobOrderListController.tryAddWeavingMachine(
                            jobOrderListController.jobOrderDetail.value.id,
                            selectedElastics,
                            selectedMachine.id);
                      },
                      child:
                          Text(style: TextStyle(color: Colors.white), "Save"))
                ],
              ),
            ))
      ])),
    );
  }
}
