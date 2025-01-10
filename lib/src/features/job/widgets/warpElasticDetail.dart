import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../elastics/screens/elasticDetailScreen.dart';

class Warpelasticdetail extends StatefulWidget {
  int i;

  Map elastic;

  Warpelasticdetail(this.i, this.elastic, {super.key});

  @override
  State<Warpelasticdetail> createState() => _Warpelasticdetail(i, elastic);
}

class _Warpelasticdetail extends State<Warpelasticdetail> {
  int i;
  Map elastic;
  _Warpelasticdetail(this.i, this.elastic);

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
                    elastic['id']['name']!),
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
                    elastic['quantity'].toString()),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
                onPressed: () {
                  Get.to(() => ElasticDetailScreen(),
                      arguments: [elastic['id']['_id']]);
                },
                child: const Text("View Elastic Details"))
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
