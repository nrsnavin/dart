import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../common _widgets/appBar.dart';
import '../../authentication/controllers/login_controller.dart';
import '../controllers/new_customer_controller.dart';


class Newcustomerform extends StatefulWidget {
  const Newcustomerform({super.key});

  @override
  State<Newcustomerform> createState() => _NewcustomerformState();
}

class _NewcustomerformState extends State<Newcustomerform> {
  final loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final gstinController = TextEditingController();
  final contaceController = TextEditingController();
  final contactNumberController = TextEditingController();
  final purchaseNameController = TextEditingController();
  final purchaseEmailController = TextEditingController();
  final purchasePhoneController = TextEditingController();
  final accountsNameController = TextEditingController();
  final accountsEmailController = TextEditingController();
  final accountsPhoneController = TextEditingController();
  final merchandiserNameController = TextEditingController();
  final merchandiserEmailController = TextEditingController();
  final merchandiserPhoneController = TextEditingController();

  final customerCreationController = Get.put(CustomerCreationController());
  String? selectedValue = 'NET30';
  List<String> listOfValue = ['NET30', 'NET60', 'NET90', 'CASH', 'ADVANCE'];
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: NAppBar(
        showBackArrow: true,
        actions: [
          TextButton(
              onPressed: () => {
                    if (_formKey.currentState!.validate())
                      {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        customerCreationController.tryPost(
                            nameController.value.text,
                            emailController.value.text,
                            gstinController.value.text,
                            contaceController.value.text,
                            contactNumberController.value.text,
                            selectedValue!,
                            {
                              'name': purchaseNameController.value.text,
                              'email': purchaseEmailController.value.text,
                              'mobile': purchasePhoneController.value.text
                            },
                            {
                              'name': accountsNameController.value.text,
                              'email': accountsEmailController.value.text,
                              'mobile': accountsPhoneController.value.text
                            },
                            {
                              'name': merchandiserNameController.value.text,
                              'email': merchandiserEmailController.value.text,
                              'mobile': merchandiserPhoneController.value.text
                            },
                            context),
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        )
                      }
                  },
              child: Obx(() => customerCreationController.isLoading.value
                  ? const SpinKitRotatingCircle(
                      color: Colors.blueAccent,
                      size: 20.0,
                    )
                  : Text("Save")))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: MediaQuery.sizeOf(context).width - 10,
            child: (Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Add New Customer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
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
                                return 'Please enter some Value';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Comapany Name",
                                hintText: "Enter Company Name ",
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
                                hintText: "Enter email",
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
                                hintText: "Enter GSTIN",
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
                          SizedBox(
                            height: 10,
                          ),
                          Text("Payment Terms"),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            value: selectedValue,
                            hint: const Text("Payment terms"),
                            items:
                                listOfValue.map<DropdownMenuItem<String>>((p) {
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
                          ExpansionTile(
                            title: const Text('Add Purchase Contact'),
                            children: <Widget>[
                              TextFormField(
                                controller: purchaseNameController,
                                decoration: const InputDecoration(
                                    labelText: "Purchase Contact Name",
                                    hintText: "Enter  Purchase Contact Name",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: purchaseEmailController,
                                decoration: const InputDecoration(
                                    labelText: "Purchase Email",
                                    hintText: "Enter Purchase Email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: purchasePhoneController,
                                decoration: const InputDecoration(
                                    labelText: "Purchase Phone Number",
                                    hintText: "Enter Purchase Phone Number",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: const Text('Add Accounts Contact'),
                            children: <Widget>[
                              TextFormField(
                                controller: accountsNameController,
                                decoration: const InputDecoration(
                                    labelText: "Acoounts Contact Name",
                                    hintText: "Enter  Accounts Contact Name",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: accountsEmailController,
                                decoration: const InputDecoration(
                                    labelText: "Accounts Email",
                                    hintText: "Enter Acounts Email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: accountsPhoneController,
                                decoration: const InputDecoration(
                                    labelText: "Accounts Phone Number",
                                    hintText: "Enter  Accounts Phonne NUmber",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            title: const Text('Add Merchandiser Contact'),
                            children: <Widget>[
                              TextFormField(
                                controller: merchandiserNameController,
                                decoration: const InputDecoration(
                                    labelText: "Merchandiser Contact Name",
                                    hintText:
                                        "Enter  Merchandiser Contact Name",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: merchandiserEmailController,
                                decoration: const InputDecoration(
                                    labelText: "Merchandiser Email",
                                    hintText: "Enter Merchandiser Email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: merchandiserPhoneController,
                                decoration: const InputDecoration(
                                    labelText: "Merchandiser Phone Number",
                                    hintText: "Enter Merchandiser Phone",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ))
              ],
            )),
          ),
        ),
      ),
    ));
  }
}
