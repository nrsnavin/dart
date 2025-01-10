
import 'package:flutter/material.dart';

class Expansionformfield extends FormField<Contacts> {
  Expansionformfield({
    super.key,
    ExpansionInputController? controller,
    ValueChanged<Contacts?>? onChanged,
    super.validator,
    super.autovalidateMode,
  }) : super(
          initialValue: controller?.value,
          builder: (state) {
            void onChangedHandler(Contacts? value) {
              state.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return Column(
              children: <Widget>[
                ExpansionTile(
                  title: const Text('Add Purchase Contact'),
                  children: <Widget>[
                    TextFormField(

                      decoration:  const InputDecoration(
                          labelText: "Purchase Contact Name",
                          hintText: "Enter  Purchase Contact Name",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(

                      decoration: const InputDecoration(
                          labelText: "Purchase Email",
                          hintText: "Enter Purchase Email",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(

                      decoration: const InputDecoration(
                          labelText: "Purchase Phone Number",
                          hintText: "Enter Purchase Phone Number",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),

                  ],
                ),
                ExpansionTile(
                  title: const Text('Add Accounts Contact'),
                  children:<Widget>[
                    TextFormField(

                      decoration:  const InputDecoration(
                          labelText: "Acoounts Contact Name",
                          hintText: "Enter  Accounts Contact Name",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(

                      decoration: const InputDecoration(
                          labelText: "Accounts Email",
                          hintText: "Enter Acounts Email",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(

                      decoration: const InputDecoration(
                          labelText: "Accounts Phone Number",
                          hintText: "Enter  Accounts Phonne NUmber",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),

                  ],
                ),
                ExpansionTile(
                  title: const Text('Add Merchandiser Contact'),
                  children:<Widget>[
                    TextFormField(

                      decoration:  const InputDecoration(
                          labelText: "Merchandiser Contact Name",
                          hintText: "Enter  Merchandiser Contact Name",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(

                      decoration: const InputDecoration(
                          labelText: "Merchandiser Email",
                          hintText: "Enter Merchandiser Email",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(

                      decoration: const InputDecoration(
                          labelText: "Merchandiser Phone Number",
                          hintText: "Enter Merchandiser Phone",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),

                  ],
                ),




              ],
            );
          },
        );
}

class Contacts {
  Contacts();
  late Object purchase;
  late Object accounts;
  late Object merch;
}

class ExpansionField extends StatefulWidget {
  const ExpansionField({
    Key? key,
    this.controller,
    this.onChanged,
    this.side = BorderSide.none,
  }) : super(key: key);
  final ExpansionInputController? controller;
  final ValueChanged<Contacts?>? onChanged;
  final BorderSide side;

  @override
  State<ExpansionField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ExpansionField> {
  late ExpansionInputController controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? ExpansionInputController();
    controller.addListener(() {
      widget.onChanged?.call(controller.value);
    });
  }

  @override
  void didUpdateWidget(covariant ExpansionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller = widget.controller ?? ExpansionInputController();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const InkResponse();
  }
}

class ExpansionInputController extends ValueNotifier<Contacts?> {
  ExpansionInputController({Contacts? initialValue}) : super(initialValue);

  set file(Contacts newValue) {
    if (true) return;

    value = newValue;
    notifyListeners();
  }
}
