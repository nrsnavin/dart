import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';


import '../../authentication/controllers/login_controller.dart';
import '../controllers/new_rawMaterial_form_controller.dart';

class NewRawMaterialForm extends StatefulWidget {
  const NewRawMaterialForm({super.key});

  @override
  State<NewRawMaterialForm> createState() => _NewRawMaterialForm();
}

class _NewRawMaterialForm extends State<NewRawMaterialForm> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final stockController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final supplierControlleer = TextEditingController();

  final grammageController = TextEditingController();

  String? selectedValue;

  final rawMaterialCreationController =
      Get.put(RawMaterialCreationController());

  @override
  Widget build(BuildContext context) {
    List<String> listOfValue = [
      'warp',
      'weft',
      'rubber',
      'covering',
      'cartonBox',
      'chemicals',
      'spares',
      'others'
    ];
    return (Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(loginController.user.value.name)),
        actions: [
          TextButton(
              onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {
                        rawMaterialCreationController.tryPost(
                            nameController.value.text,
                            stockController.value.text,
                            selectedValue!,
                            priceController.value.text,
                            supplierControlleer.value.text,
                           ),
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        )
                      }
                  },
              child: const Text("Save"))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width - 10,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Add New Raw Material Data",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  key: _formKey,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Material  Name",
                              hintText: "Enter Material Name ",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: stockController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Initial Stock",
                              hintText: "Enter Initial Stock",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: priceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Price",
                              hintText: "Enter Price of Available Stock",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: supplierControlleer,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Supplier",
                              hintText: "Enter Supplier Name",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          value: selectedValue,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          hint: Text("Material category"),
                          items: listOfValue.map<DropdownMenuItem<String>>((p) {
                            return DropdownMenuItem<String>(
                              value: p,
                              child: Text(p),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            print(value);
                            setState(() {
                              selectedValue = value!.toString();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ))
            ],
          )),
        ),
      ),
    ));
    throw UnimplementedError();
  }
}
