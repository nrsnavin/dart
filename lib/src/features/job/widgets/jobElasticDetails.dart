import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../elastics/screens/elasticDetailScreen.dart';

class Jobelasticdetails extends StatefulWidget {
  int i;

  Map elastic;

  Jobelasticdetails(this.i, this.elastic, {super.key});

  @override
  State<Jobelasticdetails> createState() => _Jobelasticdetails(i, elastic);
}

class _Jobelasticdetails extends State<Jobelasticdetails> {
  int i;
  Map elastic;
  _Jobelasticdetails(this.i, this.elastic);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.black, style: BorderStyle.solid, width: 3),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Column(
          children: [
            Text("Elastic No-" + (i + 1).toString()),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    "Name:"),
                Text(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    elastic['name']!),
              ],
            ),
            Row(
              children: [
                const Text(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    "Ordered Quantity:"),
                Text(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    elastic['ordered'].toString()),
              ],
            ),
            Row(
              children: [
                const Text(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    "Produced Quantity:"),
                Text(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    elastic['produced'].toString()),
              ],
            ),
            Row(
              children: [
                const Text(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    "Wastage Quantity:"),
                Text(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    elastic['wastage'].toString()),
              ],
            ),
            Row(
              children: [
                const Text(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    "Packed Quantity:"),
                Text(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    elastic['packed'].toString()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
                onPressed: () {
                  Get.to(() => ElasticDetailScreen(),
                      arguments: [elastic['id']]);
                },
                child: const Text("View Elastic Details"))
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
