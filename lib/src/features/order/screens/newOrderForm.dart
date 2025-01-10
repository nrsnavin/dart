import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:increment_decrement_form_field/increment_decrement_form_field.dart';


import 'package:date_field/date_field.dart';


import '../../../common _widgets/appBar.dart';
import '../../authentication/controllers/login_controller.dart';
import '../../customers/controllers/customer_list_controller.dart';
import '../controllers/new_order_controller.dart';
import '../widgets/elasticSelect.dart';

class NewOrderForm extends StatefulWidget {
  @override
  State<NewOrderForm> createState() => _NewOrderFormState();
}

class _NewOrderFormState extends State<NewOrderForm> {
  final _formKey = GlobalKey<FormState>();
  final poController = TextEditingController();
  final descriptionController = TextEditingController();

  final customerListController = Get.put(CustomerListController());

  final orderCreationController = Get.put(OrderCreationController());

  var date = DateTime.now();
  var delDate = DateTime.now();
  var customersList;
  int noOfElastics = 1;

  var selectedElastics;
  var selectedCustomer;

  @override
  void initState() {
    customerListController.getCustomers();
    customersList = customerListController.customersList;
    selectedElastics = List.filled(noOfElastics, {});
    super.initState();
  }

  void onTap(int i, int mtrs, String s) {
    selectedElastics[i] = {'quantity': mtrs, 'id': s};
  }

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
                        orderCreationController.tryPost(
                            selectedCustomer,
                            date.toString(),
                            delDate.toString(),
                            poController.value.text,
                            descriptionController.value.text,
                            selectedElastics)
                      },
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    )
                  },
              child: const Text("Save"))
        ],
      ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child:
                  (Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: (Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Add New Order",
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
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Select Customer';
                                    }
                                    return null;
                                  },
                                  value: selectedCustomer,
                                  hint: const Text("Customer Name"),
                                  items: customersList
                                      .map<DropdownMenuItem<String>>((p) {
                                    return DropdownMenuItem<String>(
                                      value: p.id,
                                      child: Text(p.name.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCustomer = value;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DateTimeFormField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Select Date';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Enter Order Date',
                              ),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 10)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 10)),
                              initialPickerDateTime: DateTime.now(),
                              onChanged: (DateTime? value) {
                                date = value!;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DateTimeFormField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Select Delivery Date';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Enter Delivery Date',
                              ),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 10)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 10)),
                              initialPickerDateTime: DateTime.now(),
                              onChanged: (DateTime? value) {
                                delDate = value!;
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2)))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Enter No Of Elastics in Order",
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
                              initialValue: noOfElastics,
                              autovalidateMode: AutovalidateMode.always,
                              onDecrement: (currentValue) {
                                setState(() {
                                  noOfElastics = noOfElastics - 1;
                                });
                                selectedElastics =
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
                                  noOfElastics = noOfElastics + 1;
                                });
                                selectedElastics =
                                    List.filled(currentValue! + 1, {});
                                return currentValue + 1;
                              },
                              onSaved: (value) {},
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            for (var i = 0; i < noOfElastics; i++)
                              Elasticselect(i, onTap),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(noOfElastics.toString()),
                          ]))),
                )
              ])),
            ),
          ),
        ),
    ));
    throw UnimplementedError();
  }
}
