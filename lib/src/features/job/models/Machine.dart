import 'dart:developer';

class Machine {
  String id;
  String ID;
  String manufacturer;
  String dateOfPurchase;
  int noOfHead;
  int noOfHooks;

  // int pendingOrders;

  Machine(
      {required this.id,
      required this.dateOfPurchase,
      required this.ID,
      required this.manufacturer,
      required this.noOfHead,
      required this.noOfHooks});

  factory Machine.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'ID': String ID,
        'manufacturer': String manufacturer,
        'DateOfPurchase': String dateOfPurchase,
        'NoOfHead': int NoOfHead,
        'NoOfHooks': int NoOfHooks,
      } =>
        Machine(
            id: id,
            dateOfPurchase: dateOfPurchase,
            ID: ID,
            manufacturer: manufacturer,
            noOfHead: NoOfHead,
            noOfHooks: NoOfHooks),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
