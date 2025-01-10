import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/new_elastic_controller.dart';

class Warpdata extends StatefulWidget {
  int i;
  void Function(int i, int ends, String s, String t,double w) onTap;
  Warpdata(this.i, this.onTap, {super.key});

  @override
  State<Warpdata> createState() => _Warpdata(i, onTap);
}

class _Warpdata extends State<Warpdata> {
  final endsController = TextEditingController();
  final typeController = TextEditingController();
  final weightController = TextEditingController();
  final elasticFormController = Get.put(ElasticCreationController());

  var warpsFuture;
  var selectedValue;
  int i;
  void Function(int i, int ends, String s, String t,double w) onTap;
  _Warpdata(this.i, this.onTap);

  @override
  void initState() {
    // TODO: implement initState

    elasticFormController.getDataForNewElastic();

    warpsFuture = elasticFormController.warpList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.black, style: BorderStyle.solid, width: 3),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Column(
          children: [
            Text("Warp-" + (i + 1).toString()),
            Obx(
              () =>elasticFormController.isLoading.value?const SpinKitRotatingCircle(
                color: Colors.blue,
                size: 10.0,
              ):


              DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please Select Warp yarn';
                    }
                    return null;
                  },
                  value: selectedValue,
                  hint: Text("Yarn Shade"),
                  items: warpsFuture.map<DropdownMenuItem<String>>((p) {
                    return DropdownMenuItem<String>(
                      value: p.id,
                      child: Text(p.name.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      onTap(i, int.parse(endsController.value.text),
                          selectedValue, typeController.value.text,double.parse(weightController.value.text));
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: endsController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  onTap(i, int.parse(value), selectedValue,
                      typeController.value.text,double.parse(weightController.value.text));
                });
              },
              decoration: const InputDecoration(
                  labelText: "Ends",
                  hintText: "Enter Number of Ends",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: weightController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter weight';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  onTap(i, int.parse(value), selectedValue,
                      typeController.value.text,double.parse(value));
                });
              },
              decoration: const InputDecoration(
                  labelText: "Weight",
                  hintText: "Enter Weight Per Meter",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: typeController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  onTap(i, int.parse(endsController.value.text), selectedValue,
                      value,double.parse(weightController.value.text));
                });
              },
              decoration: const InputDecoration(
                  labelText: "Type",
                  hintText: "Enter Type of Warp",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
