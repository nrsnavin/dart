import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:increment_decrement_form_field/increment_decrement_form_field.dart';


import 'package:date_field/date_field.dart';

import '../../../common _widgets/appBar.dart';
import '../../authentication/controllers/login_controller.dart';
import '../../customers/controllers/customer_list_controller.dart';
import '../controllers/new_rawMaterial_form_controller.dart';
import '../widgets/materialSelect.dart';

class MaterialInwardAdd extends StatefulWidget {
  @override
  State<MaterialInwardAdd> createState() => _MaterialInwardAdd();
}

class _MaterialInwardAdd extends State<MaterialInwardAdd> {
  final poController = TextEditingController();
  final referenceController = TextEditingController();

  final rawMaterialCreationController =
      Get.put(RawMaterialCreationController());

  var date = DateTime.now();

  var materialsList;
  int noOfMaterials = 1;

  var selectedMaterials;

  @override
  void initState() {
    rawMaterialCreationController.getMaterials();
    materialsList = rawMaterialCreationController.materials;
    selectedMaterials = List.filled(noOfMaterials, {});
    super.initState();
  }

  void onTap(int i, int q, String s) {
    selectedMaterials[i] = {'quantity': q, 'id': s};
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: NAppBar(
        showBackArrow: true,
        actions: [
          TextButton(
              onPressed: () => {
                    rawMaterialCreationController.tryPostMaterialInward(
                        date.toString(),
                        poController.value.text,
                        referenceController.value.text,
                        selectedMaterials)
                  },
              child: const Text("Save"))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: (Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: (Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add Materials Inward",
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
                            labelText: 'Enter  Date',
                          ),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 10)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 10)),
                          initialPickerDateTime: DateTime.now(),
                          onChanged: (DateTime? value) {
                            date = value!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: poController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Purchase Order",
                              hintText:
                                  "Enter Purchase Order Number of Customer",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: referenceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Reference",
                              hintText: "Enter Bill no or Any",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Enter No Of Materials",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IncrementDecrementFormField(
                          displayBuilder: (value, field) {
                            return Text(
                              value!.toString(),
                            );
                          },
                          initialValue: noOfMaterials,
                          autovalidateMode: AutovalidateMode.always,
                          onDecrement: (currentValue) {
                            setState(() {
                              noOfMaterials = noOfMaterials - 1;
                            });
                            selectedMaterials =
                                List.filled(currentValue! - 1, {});
                            return currentValue! - 1;
                          },
                          validator: (value) {
                            if (value == null || value > 10 || value < 0) {
                              return "Value out of bounds";
                            }
                            return null;
                          },
                          onIncrement: (currentValue) {
                            setState(() {
                              noOfMaterials = noOfMaterials + 1;
                            });
                            selectedMaterials =
                                List.filled(currentValue! + 1, {});
                            return currentValue + 1;
                          },
                          onSaved: (value) {},
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (var i = 0; i < noOfMaterials; i++)
                          MaterialSelect(i, onTap),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(noOfMaterials.toString()),
                      ]))),
            )
          ])),
        ),
      ),
    ));
    throw UnimplementedError();
  }
}
