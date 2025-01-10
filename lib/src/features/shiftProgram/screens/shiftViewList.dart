import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';


import '../../../common _widgets/appBar.dart';
import '../../elastics/models/elastic.dart';
import '../controllers/shift_controller.dart';
import '../models/shiftOpenListModel.dart';
import 'shiftDetailScreen.dart';

class ViewOpenShifts extends StatefulWidget {
  const ViewOpenShifts({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewOpenShifts();
  }
}

class _ViewOpenShifts extends State<ViewOpenShifts> {
  final shiftController = Get.put(ShiftController());

  final searchController = TextEditingController();

  late List<ShiftOpenListModel> postsFuture =shiftController.shiftsOpen ;

  List<ShiftOpenListModel>? orders;

  void _latestFormat() {
    final text = searchController.text;
    setState(() {
      orders = postsFuture.where((c) {
        return c.employee.toLowerCase().contains(text.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    shiftController.getOpenShifts();

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
                  hintText: 'Search Shift By Employee Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black)),
                ),
              ),
            ),
          ),
          Obx(
                () => SizedBox(
              height: MediaQuery.sizeOf(context).height-180,
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
  Widget buildPosts(List<ShiftOpenListModel> shifts) {
    return ListView.builder(
      itemCount: shifts.length,
      itemBuilder: (context, index) {
        final order = shifts[index];
        return InkWell(
          onDoubleTap: () => {
            Get.to(() =>  ShiftDetailScreen(), arguments: [order.id])
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
                      order.job,
                      style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Employee Name:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Text(
                      order.employee!,
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
                      DateFormat("dd-MM-yyyy").format(DateTime.parse(order.date)),
                      style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
