import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(children: [
              Text(
                "BALU TAPES",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              Text("Promise On Quality"),
            ]),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize:20),

                    fixedSize: const Size.fromWidth(250),
                    elevation: 3,
                    shape: const RoundedRectangleBorder(),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.indigo),
                onPressed: () {Get.to(()=>const Login());},
                child: const Text("LOGIN"))
          ],
        ),
      ),
    ));
    throw UnimplementedError();
  }
}
