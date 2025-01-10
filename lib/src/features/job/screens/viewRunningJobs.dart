import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../../common _widgets/appBar.dart';
import '../../elastics/models/elastic.dart';
import '../../order/screens/orderDetail.dart';
import '../controllers/new_job_controller.dart';
import '../models/JobBrief.dart';
import 'jobDetailScreen.dart';

class ViewRunningJobs extends StatefulWidget {
  const ViewRunningJobs({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewRunningJobs();
  }
}

class _ViewRunningJobs extends State<ViewRunningJobs> {
  final jobController = Get.put(JobCreationController());

  final searchController = TextEditingController();

  late List<JobBrief> postsFuture = jobController.runningJobList;

  List<JobBrief>? orders;

  void _latestFormat() {
    final text = searchController.text;
    setState(() {
      orders = postsFuture.where((c) {
        return c.customer!.toLowerCase().contains(text.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    jobController.getRunningJobs();

    searchController.addListener(_latestFormat);
    orders = postsFuture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          NAppBar(showBackArrow: true,),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Job By Customer Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black)),
                ),
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              height: MediaQuery.sizeOf(context).height-200,
              child: Center(
                // FutureBuilder
                child: postsFuture.isNotEmpty
                    ? buildPosts(orders!)
                    : const Text("Loading"),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // function to display fetched data on screen
  Widget buildPosts(List<JobBrief> job) {
    return ListView.builder(
      itemCount: job.length,
      itemBuilder: (context, index) {
        final order = job[index];
        return InkWell(
          onDoubleTap: () => {
            Get.to(() =>  JobOrderDetailScreen(), arguments: [order.id])
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
                      "Job No-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.jobOrderNo,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Customer Name:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Text(
                      order.customer!.truncateTo(15),
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Date ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      DateFormat("dd-MM-yyyy").format(order.date!),
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Status-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.status,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
