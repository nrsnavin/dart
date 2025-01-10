import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';


import '../../../common _widgets/appBar.dart';
import '../../customers/controllers/customer_list_controller.dart';
import '../controllers/new_elastic_controller.dart';
import '../widgets/warpData.dart';

class NewElasticForm extends StatefulWidget {
  const NewElasticForm({super.key});

  @override
  State<NewElasticForm> createState() => _NewElasticForm();
}

class _NewElasticForm extends State<NewElasticForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final widthController = TextEditingController();
  final noOfWarpsController = TextEditingController();
  final pickController = TextEditingController();
  final designHooksController = TextEditingController();
  final weightController = TextEditingController();
  final elongationController = TextEditingController();
  final recoveryController = TextEditingController();
  final strechController = TextEditingController();
  final imageUrlController = TextEditingController();
  final rubberEndsController = TextEditingController();
  final drawTypeController = TextEditingController();

  final elasticFormController = Get.put(ElasticCreationController());

  final weftWeightController = TextEditingController();

  final coveringWeightController = TextEditingController();

  final rubberWeightController = TextEditingController();

  var rubbersFuture;
  var warpsFuture;
  var weftsFuture;
  var coveringsFuture;

  int noOfWarps = 2;

  var selectedRubber;
  var selectedCovering;
  var selectedWeft;
  var selectedWarps;

  @override
  void initState() {
    // TODO: implement initState
    noOfWarpsController.text = "2";

    elasticFormController.getDataForNewElastic();

    rubbersFuture = elasticFormController.rubberList;
    weftsFuture = elasticFormController.weftList;
    warpsFuture = elasticFormController.warpList;
    coveringsFuture = elasticFormController.coveringList;
    selectedWarps = List.filled(noOfWarps, {});
    noOfWarpsController.addListener(_latestFormat);
    super.initState();
  }

  void onTap(int i, int ends, String s, String t, double w) {
    selectedWarps[i] = {'ends': ends, 'id': s, 'type': t, 'weight': w};
  }

  void _latestFormat() {
    final text = noOfWarpsController.text;
    selectedWarps = List.filled(int.parse(text), {});
    setState(() {
      noOfWarps = int.parse(text);
    });
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
                        elasticFormController.tryPost(
                            nameController.value.text,
                            {
                              'id': selectedRubber,
                              'weight': double.parse(
                                  rubberWeightController.value.text)
                            },
                            {
                              'id': selectedWeft,
                              'weight':
                                  double.parse(weftWeightController.value.text)
                            },
                            {
                              'id': selectedCovering,
                              'weight': double.parse(
                                  coveringWeightController.value.text)
                            },
                            rubberEndsController.value.text,
                            noOfWarps,
                            selectedWarps,
                            pickController.value.text,
                            designHooksController.value.text,
                            weightController.value.text,
                            elongationController.value.text,
                            recoveryController.value.text,
                            strechController.value.text,
                            widthController.value.text,
                            imageUrlController.value.text,
                            drawTypeController.value.text)
                      },
                  },
              child: Obx(() => elasticFormController.isLoadingNew.value
                  ? const SpinKitRotatingCircle(
                      color: Colors.blue,
                      size: 20.0,
                    )
                  : Text("Save")))
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Form(
              key: _formKey,
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add New Elastic:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter elastic Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Elastic Name",
                        hintText: "Enter Elastic Name",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => elasticFormController.isLoading.value
                        ? SpinKitRotatingCircle(
                            color: Colors.blue,
                            size: 10.0,
                          )
                        : DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select Rubber';
                              }
                              return null;
                            },
                            value: selectedRubber,
                            hint: Text("Select Rubber"),
                            items: rubbersFuture
                                .map<DropdownMenuItem<String>>((p) {
                              return DropdownMenuItem<String>(
                                value: p.id,
                                child: Text(p.name.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedRubber = value;
                              });
                            }),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: rubberWeightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Rubber Weight Per Meter';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Rubber Weight",
                        hintText: "Enter Rubber Weight Per Meter",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => elasticFormController.isLoading.value
                        ? SpinKitRotatingCircle(
                            color: Colors.blue,
                            size: 10.0,
                          )
                        : DropdownButtonFormField(
                            value: selectedWeft,
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select Weft';
                              }
                              return null;
                            },
                            hint: Text("Select Weft"),
                            items:
                                weftsFuture.map<DropdownMenuItem<String>>((p) {
                              return DropdownMenuItem<String>(
                                value: p.id,
                                child: Text(p.name.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedWeft = value;
                              });
                            }),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: weftWeightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter weft Yarn Weight Per Meter';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Elastic Weft Weight",
                        hintText: "Enter Weft Weight Per Meter",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                SizedBox(height: 10,),
                  Obx(
                    () => elasticFormController.isLoading.value
                        ? const SpinKitRotatingCircle(
                            color: Colors.blue,
                            size: 10.0,
                          )
                        : DropdownButtonFormField(
                            value: selectedCovering,
                            hint: Text("Select Covering"),
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select Covering yarn';
                              }
                              return null;
                            },
                            items: coveringsFuture
                                .map<DropdownMenuItem<String>>((p) {
                              return DropdownMenuItem<String>(
                                value: p.id,
                                child: Text(p.name.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCovering = value;
                              });
                            }),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: coveringWeightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Covering Yarn Weight Per Meter';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Rubber Covering Weight",
                        hintText: "Enter Covering Weight Per Meter",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: imageUrlController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Image Url",
                        hintText: "Enter Drive Link of Elastic Image",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: rubberEndsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Rubber ENds';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Rubber Ends",
                        hintText: "Enter Rubber Ends",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: noOfWarpsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Number of Warps';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Number of Warps",
                        hintText: "Enter Number of Warps",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (var i = 0; i < noOfWarps; i++) Warpdata(i, onTap),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: pickController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pick';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Pick",
                        hintText: "Enter Weft per Inch",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: drawTypeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter DrawType';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Draw Type",
                        hintText: "Enter Draw Type",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: designHooksController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Design Hooks",
                        hintText: "Enter Design hooks",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: weightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Weight",
                        hintText: "Enter Weight Per Meter",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Testing Parameters:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: widthController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Width",
                        hintText: "Enter Width in mm ",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: elongationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Elongation",
                        hintText: "Enter Elongation @ 53N ",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: recoveryController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Recovery",
                        hintText: "Enter Recovery in %",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: strechController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: "Strech",
                        hintText: "Enter Hand Strech @ 10CM",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                  ),
                ],
              )),
            ),
          ),
        ),
      )),
    ));
    throw UnimplementedError();
  }
}
