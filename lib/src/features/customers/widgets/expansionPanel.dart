import 'package:flutter/material.dart';


class ExpansionTileExample extends StatefulWidget {
   ExpansionTileExample({super.key});
   @override
  State<ExpansionTileExample> createState() => _ExpansionTileExampleState();
}
typedef MapCallback = void Function(Map<String, dynamic> val);

class _ExpansionTileExampleState extends State<ExpansionTileExample> {


  final purchaseNameController = TextEditingController();
  final purchaseEmailController = TextEditingController();
  final purchasePhoneController = TextEditingController();
  final accountsNameController = TextEditingController();
  final accountsEmailController = TextEditingController();
  final accountsPhoneController = TextEditingController();

  final merchandiserNameController = TextEditingController();
  final merchandiserEmailController = TextEditingController();
  final merchandiserPhoneController = TextEditingController();









  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[




      ],
    );
  }
}
