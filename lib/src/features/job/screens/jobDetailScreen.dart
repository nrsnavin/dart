import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../common _widgets/appBar.dart';
import '../../order/screens/orderDetail.dart';
import '../../shiftProgram/screens/newShiftForm.dart';
import '../../shiftProgram/screens/shiftDetailScreen.dart';
import '../../wastage/screens/addWastageScreen.dart';
import '../controllers/new_job_controller.dart';
import '../models/JobOrderDetail.dart';
import '../widgets/jobElasticDetails.dart';
import 'checkingPlan.dart';
import 'coveringDetailsScreen.dart';
import 'warpingDetailsScreen.dart';
import 'weavingPlanScreen.dart';

class JobOrderDetailScreen extends StatefulWidget {
  const JobOrderDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _JobOrderDetailScreen();
  }
}

class _JobOrderDetailScreen extends State<JobOrderDetailScreen> {
  final jobOrderListController = Get.put(JobCreationController());

  var args = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState

    jobOrderListController.getJobOrderDetail(args[0]);

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
          Obx(() => jobOrderListController.isLoadingDetail.value
              ? const SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 50.0,
                )
              : buildWidget(
                  jobOrderListController.jobOrderDetail.value, context))
        ])),
      ),
    );
  }
}

Widget buildWidget(JobOrderDetail jDetail, BuildContext context) {
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
                          "Job Order Number:"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          jDetail.jobOrderNo),
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
                          "Job Status:"),
                      Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                          jDetail.status),
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
                          jDetail.customer.truncateTo(18)),
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
                          "Job Created Date:"),
                      Text(
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          DateFormat("dd-MM-yyyy").format(jDetail.date)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (jDetail.status == "checkInventory")
                    InventoryApprovedBtn(jDetail, context),
                  const SizedBox(
                    height: 30,
                  ),
                  if (jDetail.machine != null && jDetail.status == "weaving")
                    ShiftAddBtn(jDetail, context)
                  else if (jDetail.status == "warping&covering" &&
                      jDetail.warping != null &&
                      jDetail.covering != null &&
                      jDetail.covering!['status'] == "closed" &&
                      jDetail.warping!['status'] == "closed" &&
                      jDetail.machine == "Notassigned")
                    WeavingPlanBtn(jDetail, context),
                  if (jDetail.status == "finishing")
                    MarkFinishingCompleted(jDetail, context),
                  if (jDetail.status == "checking" &&
                      jDetail.checking == "Notassigned")
                    AssignCheckingBtn(jDetail, context)
                  else if (jDetail.status == "checking")
                    markCheckingFinished(jDetail, context),
                  if (jDetail.status == "packing")
                    markPackingCompleted(jDetail, context),
                  if (jDetail.status != "checkInventory")
                    markCheckingFinished(jDetail, context),
                  if (jDetail.status != "checkInventory")
                    WarpingDetailsBtn(jDetail, context),
                  if (jDetail.status != "checkInventory")
                    CoveringDetailsBtn(jDetail, context),
                  const SizedBox(
                    height: 20,
                  ),
                  if (jDetail.shiftDetails.isNotEmpty)
                    Column(
                      children: [
                        const Text(
                          "Shift Details For This Job",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (var i = 0; i < jDetail.shiftDetails.length; i++)
                          ShiftSummary(jDetail.shiftDetails[i], context),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Elastic details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  for (var i = 0; i < jDetail.elastics.length; i++)
                    Jobelasticdetails(i, jDetail.elastics[i])
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

Widget InventoryApprovedBtn(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              jobController.getJobInventoryApproval(jDetail.id);
              Get.to(const JobOrderDetailScreen(), arguments: [jDetail.id]);
            },
            child: const Text("Approve Inventory")),
      ],
    ),
  );
}

Widget WarpingDetailsBtn(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              // jobController.getJobInventoryApproval(jDetail.id);
              Get.to(const Warpingdetailsscreen(),
                  arguments: [jDetail.warping!['_id']]);
            },
            child: const Text("View Warping Details")),
      ],
    ),
  );
}

Widget CoveringDetailsBtn(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              // jobController.getJobInventoryApproval(jDetail.id);
              Get.to(const Coveringdetailsscreen(),
                  arguments: [jDetail.covering!['_id']]);
            },
            child: const Text("View Covering Details")),
      ],
    ),
  );
}

Widget WeavingPlanBtn(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              Get.to(const Weavingplanscreen(),
                  arguments: [jDetail.covering!['_id']]);
            },
            child: const Text("Plan Weaving")),
      ],
    ),
  );
}

Widget AssignCheckingBtn(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              Get.to(const CheckingplanScreen(),
                  arguments: [jDetail.covering!['_id']]);
            },
            child: const Text("Assign Checking")),
      ],
    ),
  );
}

Widget ShiftAddBtn(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              Get.to(NewShiftCreationForm(), arguments: [jDetail.id]);
            },
            child: const Text("Add Shift")),
        SizedBox(
          width: 40,
        ),
        OutlinedButton(
            onPressed: () {
              jobController.getWeavingCompleted(jDetail.id);
            },
            child: const Text("Mark Weaving Completed")),
      ],
    ),
  );
}

Widget ShiftSummary(Map shiftDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        border: Border.all(
            color: Colors.black,
            width: 3,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignCenter)),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Date-",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Text(DateFormat('dd-MM-yyyy')
                .format(DateTime.parse(shiftDetail['date'])))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Shift-",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Text(shiftDetail['shift'])
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Status-",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Text(shiftDetail['status'])
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Production-",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            Text(shiftDetail['production'].toString())
          ],
        ),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.indigo,
            ),
            onPressed: () {
              Get.to(ShiftDetailScreen(), arguments: [shiftDetail['_id']]);
            },
            child:
                Text(style: TextStyle(color: Colors.white), "View  in  Detail"))
      ],
    ),
  );
}

Widget MarkFinishingCompleted(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              jobController.getFinishingCompleted(jDetail.id);
            },
            child: const Text("Mark Finishing Completed")),
      ],
    ),
  );
}

Widget markCheckingFinished(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              Get.to(AddWastageScreen(),
                  arguments: [jobController.jobOrderDetail.value]);
            },
            child: const Text("Add Wastage ")),
      ],
    ),
  );
}

Widget markPackingCompleted(JobOrderDetail jDetail, BuildContext context) {
  final jobController = Get.put(JobCreationController());
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              jobController.getPackingCompleted(jDetail.id);
            },
            child: const Text("Mark Packing Completed")),
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 100,
        ),
        OutlinedButton(
            onPressed: () {
              // jobController.getPackingCompleted(jDetail.id);
            },
            child: const Text("Add Packing Details")),
      ],
    ),
  );
}
