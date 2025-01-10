import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../authentication/controllers/login_controller.dart';

class NewSupplierForm extends StatefulWidget {
  const NewSupplierForm({super.key});

  @override
  State<NewSupplierForm> createState() => _NewSupplierForm();
}

class _NewSupplierForm extends State<NewSupplierForm> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final gstinController = TextEditingController();
  final contaceController = TextEditingController();
  final contactNumberController = TextEditingController();

  // final customerCreationController = Get.put(CustomerCreationController());

  @override
  Widget build(BuildContext context) {
    String? _selectedValue;
    List<String> listOfValue = [
      'Yarn',
      'Spandex',
      'Rubber',
      'CartonBox',
      'Spares',
      'Others'
    ];
    return (Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(loginController.user.value.name)),
        actions: [
          TextButton(
              onPressed: () => {
                // customerCreationController.tryPost(
                //     nameController.value.text,
                //     emailController.value.text,
                //     gstinController.value.text,
                //     contaceController.value.text,
                //     contactNumberController.value.text,
                //     _selectedValue.toString()
                //     // {'name':ExpansionTileExample()},
                //     // accounts,
                //     // merchandiser)
                // )
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
                              labelText: "Supplier Name",
                              hintText: "Enter Supplier Name ",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "email",
                              hintText: "Enter Suplliers email",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: gstinController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "gstin",
                              hintText: "Enter Supplier's GSTIN",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: contaceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Contact Name",
                              hintText: "Enter Contact Name",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: contactNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Contact Number ",
                              hintText: "Enter Contact Number",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        DropdownButtonFormField(
                          value: _selectedValue,
                          hint: const Text(
                            'Product Type',
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "can't empty";
                            } else {
                              return null;
                            }
                          },
                          items: listOfValue.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val,
                              ),
                            );
                          }).toList(),
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
