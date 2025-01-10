import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../elastics/controllers/elastic_list_controller.dart';

class Weaveelastic extends StatefulWidget {
  int i;
  void Function(int i, String s) onTap;
  List elastics;
  Weaveelastic(this.i, this.onTap, this.elastics, {super.key});

  @override
  State<Weaveelastic> createState() => _Weaveelastic(i, onTap, elastics);
}

class _Weaveelastic extends State<Weaveelastic> {

  final elasticListController = Get.put(ElasticListController());

  List elastics;
  var selectedValue;
  int i;
  void Function(int i, String s) onTap;
  _Weaveelastic(this.i, this.onTap, this.elastics);

  @override
  void initState() {
    // TODO: implement initState
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
            DropdownButtonFormField(
                value: selectedValue,
                hint: Text("Elastic"),
                items: elastics.map<DropdownMenuItem<String>>((p) {
                  return DropdownMenuItem<String>(
                    key: Key(i.toString()),

                    value: p['id'],
                    child: Text(p['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  onTap(i,value.toString());
                  setState(() {
                    selectedValue = value;
                  });

                }),

          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
