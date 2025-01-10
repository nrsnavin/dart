import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../common _widgets/appBar.dart';
import '../../elastics/models/elastic.dart';
import '../controllers/productionViewController.dart';
import '../models/productionBrief.dart';
import 'productionOnDate.dart';

class ViewProduction extends StatefulWidget {
  const ViewProduction({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewProduction();
  }
}

class _ViewProduction extends State<ViewProduction> {

  final productionViewController = Get.put(ProductionViewController());
  String _range = '';

  late List<ProductionBrief> postsFuture = productionViewController.productionBriefs;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    productionViewController.getProductionDetailsInRange(
        DateFormat('yyyy-MM-dd').format(args.value.startDate),
        DateFormat('yyyy-MM-dd')
            .format(args.value.endDate ?? args.value.startDate));
    setState(() {
      _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          // ignore: lines_longer_than_80_chars
          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    });
  }

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
                    const Text(
                      "Select Date Range To View Production",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      child: SfDateRangePicker(
                          onSelectionChanged: _onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.range,
                          initialSelectedRange: PickerDateRange(
                              DateTime.now().subtract(const Duration(days: 7)),
                              DateTime.now())),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Selected range: $_range',
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

  Widget buildPosts(List<ProductionBrief> p) {
    return ListView.builder(
      itemCount: p.length,
      itemBuilder: (context, index) {
        final order = p[index];
        return InkWell(
          onDoubleTap: () => {
            Get.to(() =>  ViewProductionOnDate(), arguments: [order.date])
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
                      "Date-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.date,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}

// function to display fetched data on screen
