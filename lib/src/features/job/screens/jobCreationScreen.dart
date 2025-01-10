import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common _widgets/appBar.dart';
import '../../order/controllers/open_order_list_controller.dart';
import '../../order/models/orderDetail.dart';
import '../../order/screens/orderDetail.dart';
import '../controllers/new_job_controller.dart';


class Jobcreationscreen extends StatefulWidget {
  @override
  State<Jobcreationscreen> createState() => _Jobcreationscreen();

}

class _Jobcreationscreen extends State<Jobcreationscreen> {
  final jobOrderNumberController = TextEditingController();

  var date = DateTime.now();
  var args = Get.arguments;

  late List elasticQuantity;

  @override
  void initState() {
    elasticQuantity = args[0]
        .elastics
        .map((e) => {
              'id': e['id'],
              'quantity': 0,
            })
        .toList();
    super.initState();
  }

  void onTap(int mtrs, int i) {
    elasticQuantity[i]['quantity'] = mtrs;
  }

  final jobCreationController = Get.put(JobCreationController());
  String selectedValue = 'checkInventory';
  List<String> listOfValue = [
    "checkInventory",
    'warping&covering',
    'weaving',
    'finishing',
    'checking',
    'packing'
  ];

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: NAppBar(
        showBackArrow: true,
        actions: [
          TextButton(
              onPressed: () => {
                jobCreationController.tryPost(
                    args[0].id,
                    date.toString(),
                    selectedValue,
                    elasticQuantity,
                    args[0].customer,
                    )
              },
              child: const Text("Save"))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Add New Job order",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Job Order Date',
                ),
                initialValue: date,
                firstDate: DateTime.now().subtract(const Duration(days: 10)),
                lastDate: DateTime.now().add(const Duration(days: 10)),
                initialPickerDateTime: DateTime.now(),
                onChanged: (DateTime? value) {
                  date = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    "Customer Name-",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    args[0].customer.toString().truncateTo(15),
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // TextFormField(
              //   controller: jobOrderNumberController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(
              //       labelText: "Job Order Number",
              //       hintText: "Auto-Generated Job Order Number",
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(2)))),
              // ),
              DropdownButtonFormField(
                value: selectedValue,
                hint: const Text("Stage"),
                items: listOfValue.map<DropdownMenuItem<String>>((p) {
                  return DropdownMenuItem<String>(
                    value: p,
                    child: Text(p),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              for (var i = 0; i < args[0].elastics.length; i++)
                elasticProductionIp(args[0], context, i, onTap)
            ],
          )),
        ),
      ),
    ));
    throw UnimplementedError();
  }
}

Widget elasticProductionIp(
    OrderDetail oDetail, BuildContext context, int i, Function onTap) {
  final orderListController = Get.put(OpenOrderListController());

  return Container(
      child: (Column(
    children: [
      const SizedBox(
        height: 10,
      ),
      Text("Elastic-${i + 1}"),
      Row(
        children: [
          const Text(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              "Name:"),
          Text(
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              oDetail.elastics[i]['name']!),
        ],
      ),
      Row(
        children: [
          const Text(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              "Ordered Quantity:"),
          Text(
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              oDetail.elastics[i]['ordered'].toString()),
        ],
      ),
      Row(
        children: [
          const Text(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              "Produced Quantity:"),
          Text(
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              oDetail.elastics[i]['produced'].toString()),
        ],
      ),
      Row(
        children: [
          const Text(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              "Pending Quantity:"),
          Text(
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              oDetail.elastics[i]['pending'].toString()),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      TextField(
        onChanged: (String val) {
          onTap(int.parse(val), i);
        },
        keyboardType: TextInputType.numberWithOptions(),
        decoration: const InputDecoration(
            labelText: "Quanity For Production",
            hintText: "Enter Quantity For this Job",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)))),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  )));
}
