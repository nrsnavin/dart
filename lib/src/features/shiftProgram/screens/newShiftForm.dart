import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


import '../../../common _widgets/appBar.dart';
import '../controllers/shift_controller.dart';

class NewShiftCreationForm extends StatefulWidget {
  @override
  State<NewShiftCreationForm> createState() => _NewShiftCreationForm();
}

class _NewShiftCreationForm extends State<NewShiftCreationForm> {
  final shiftController = Get.put(ShiftController());
  var date = DateTime.now();

  var employeesList;
  var elasticsList;
  final descriptionController = TextEditingController();
  var shiftText;

  var selectedEmployee;
  var selectedElastic;

  @override
  void initState() {
    shiftController.getWeavingEmployees();
    employeesList = shiftController.employeesWeave;

    super.initState();
  }

  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {


    return (Scaffold(
      appBar: NAppBar(
        showBackArrow: true,
        actions: [TextButton(onPressed: () => {}, child: const Text("Save"))],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Add New Shift",
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
                    value: selectedEmployee,
                    hint: const Text("Emploee Name"),
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
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Shift Date',
                ),
                firstDate: DateTime.now().subtract(const Duration(days: 10)),
                lastDate: DateTime.now().add(const Duration(days: 10)),
                initialPickerDateTime: DateTime.now(),
                onChanged: (DateTime? value) {
                  date = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: "Description",
                    hintText: "Enter Description if Any",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                  value: shiftText,
                  hint: const Text("Shift "),
                  items: ["Day", "Night"].map<DropdownMenuItem<String>>((p) {
                    return DropdownMenuItem<String>(
                      value: p,
                      child: Text(p),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      shiftText = value;
                    });
                  }),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  shiftController.tryPost(args[0], date, shiftText,
                      descriptionController.value.text, selectedEmployee);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shadowColor: Colors.black,
                    elevation: 2,
                    fixedSize: const Size.fromWidth(300)),
                child: const Text(
                  "Assign Shift",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
        ),
      ),
    ));
  }
}
