import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/new_rawMaterial_form_controller.dart';


class MaterialSelect extends StatefulWidget {
  int i;
  void Function(int i, int ends, String s) onTap;
  MaterialSelect(this.i, this.onTap, {super.key});

  @override
  State<MaterialSelect> createState() => _MaterialSelect(i, onTap);
}

class _MaterialSelect extends State<MaterialSelect> {
  final qController = TextEditingController();
  final materialController = Get.put(RawMaterialCreationController());

  var materialsFuture;
  var selectedValue;
  int i;
  void Function(int i, int ends, String s) onTap;
  _MaterialSelect(this.i, this.onTap);

  @override
  void initState() {
    // TODO: implement initState

    materialController.getMaterials();

    materialsFuture = materialController.materials;

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
            Text("Material No-" + (i + 1).toString()),
            Obx(
              () => materialsFuture.length>0? DropdownMenu<String>(
                  width: MediaQuery.of(context).size.width - 20,
                  hintText: "Select Elastic",
                  requestFocusOnTap: true,
                  enableFilter: true,
                  label: const Text('Select Material Inward'),
                  onSelected: (menu) {
                    selectedValue = menu;
                  },
                  dropdownMenuEntries:
                      materialsFuture.map<DropdownMenuEntry<String>>((p) {
                    return DropdownMenuEntry<String>(
                      value: p.id,
                      label: p.name.toString(),
                    );
                  }).toList()):Text("loa"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: qController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Quantity ",
                  hintText: "Enter Recieved Quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)))),
            ),
            TextButton(
                onPressed: () =>
                    onTap(i, int.parse(qController.value.text), selectedValue),
                child: Text("SAVE"))
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
