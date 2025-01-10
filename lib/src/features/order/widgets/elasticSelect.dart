import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../elastics/controllers/elastic_list_controller.dart';


class Elasticselect extends StatefulWidget {
  int i;
  void Function(int i, int ends, String s) onTap;
  Elasticselect(this.i, this.onTap, {super.key});

  @override
  State<Elasticselect> createState() => _Elasticselect(i, onTap);
}

class _Elasticselect extends State<Elasticselect> {
  final metersController = TextEditingController();
  final elasticListController = Get.put(ElasticListController());

  var elasticsFuture;
  var selectedValue;
  int i;
  void Function(int i, int ends, String s) onTap;
  _Elasticselect(this.i, this.onTap);

  @override
  void initState() {
    // TODO: implement initState

    elasticListController.getElastics();

    elasticsFuture = elasticListController.elasticList;

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
            Text("Elastic No-" + (i + 1).toString()),
            Obx(
              () => DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please Select Elastic';
                    }
                    return null;
                  },
                  value: selectedValue,
                  hint: Text("Elastic"),
                  items: elasticsFuture.map<DropdownMenuItem<String>>((p) {
                    return DropdownMenuItem<String>(
                      value: p.id,
                      child: Text(p.name.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      onTap(i, int.parse(metersController.value.text),
                          selectedValue);
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: metersController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (s) => {onTap(i, int.parse(s), selectedValue)},
              decoration: const InputDecoration(
                  labelText: "Meters Ordered",
                  hintText: "Enter Meters in Order",
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
