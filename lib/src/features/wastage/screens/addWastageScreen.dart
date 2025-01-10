import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../common _widgets/appBar.dart';
import '../../shiftProgram/controllers/shift_controller.dart';
import '../controllers/new_wastage_controller.dart';

class AddWastageScreen extends StatefulWidget {
  @override
  State<AddWastageScreen> createState() => _AddWastageScreen();
}

class _AddWastageScreen extends State<AddWastageScreen> {
  final wastageController = Get.put(WastageController());
  final shiftController = Get.put(ShiftController());

  var selectedEmployee;

  var employeesList;
  var elasticsList;
  final reasonController = TextEditingController();
  final quantityController = TextEditingController();
  var shiftText;

  var selectedElastic;
  var args = Get.arguments;

  void initState() {
    shiftController.getWeavingEmployees();
    employeesList = shiftController.employeesWeave;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    elasticsList = args[0].elastics;
    return (Scaffold(
      appBar: NAppBar(showBackArrow: true,),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Add Wastage Details",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => DropdownButtonFormField(
                    enableFeedback: true,
                    value: selectedEmployee,
                    hint: const Text("Employee Name"),
                    items: employeesList.map<DropdownMenuItem<String>>((p) {
                      return DropdownMenuItem<String>(
                        value: p.id,
                        child: Text(p.name.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedEmployee = value;
                      });
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownMenu<String>(
                  width: MediaQuery.of(context).size.width - 20,
                  hintText: "Select Elastic",
                  requestFocusOnTap: true,
                  enableFilter: true,
                  label: const Text('Select Elastic In Wastage'),
                  onSelected: (menu) {
                    selectedElastic = menu;
                  },
                  dropdownMenuEntries:
                      elasticsList.map<DropdownMenuEntry<String>>((p) {
                    return DropdownMenuEntry<String>(
                      value: p['id'],
                      label: p['name'].toString(),
                    );
                  }).toList()),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: quantityController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Quantity",
                    hintText: "Enter Quantity Of Wastage",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: reasonController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Reason",
                    hintText: "Enter Reason For Wastage",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  wastageController.tryPost(
                      selectedElastic,
                      args[0].id,
                      selectedEmployee,
                      int.parse(quantityController.value.text),
                      reasonController.value.text);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shadowColor: Colors.black,
                    elevation: 2,
                    fixedSize: const Size.fromWidth(300)),
                child: const Text(
                  "Add Wastage",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
        ),
      ),
    ));
    throw UnimplementedError();
  }
}

class ElasticItem {
  final int id;
  final String name;

  ElasticItem(this.id, this.name);
}
