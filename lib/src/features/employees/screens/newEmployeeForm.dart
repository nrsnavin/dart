import 'package:flutter/material.dart';

import '../../../common _widgets/appBar.dart';


class NewEmployeeCreationForm extends StatefulWidget {
  @override
  State<NewEmployeeCreationForm> createState() => _NewEmployeeCreationForm();
}

class _NewEmployeeCreationForm extends State<NewEmployeeCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final aadharController = TextEditingController();
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final phoneNumberController = TextEditingController();


  String? department;
  List<String> listOfValue = ['Warping', 'Covering', 'Weaving', 'Finishing', 'Checking','Packing','General'];
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
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: " Name",
                              hintText: "Enter Employee Name ",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Phone Number ",
                              hintText: "Enter Phone Number",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: aadharController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: " AADHAR",
                              hintText: "Enter Aadhar  Number ",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: roleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Role ",
                              hintText: "Enter Employee Role",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(2)))),
                        ),
                        DropdownButtonFormField(

                          hint: const Text("Department"),
                          items: listOfValue.map<DropdownMenuItem<String>>((p) {
                            return DropdownMenuItem<String>(
                              value: p,
                              child: Text(p),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              department = value!;
                            });
                          },
                        ),

                      ],
                    ),
                  ))
            ],
          )),
        ),
      ),
    ));
  }
}
