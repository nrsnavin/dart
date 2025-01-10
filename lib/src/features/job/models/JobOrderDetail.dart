import 'dart:developer';

class JobOrderDetail {
  String id;
  String status;
  DateTime date;
  String jobOrderNo;
  String order;
  String customer;
  List shiftDetails;
  List elastics;
  Map? warping;
  Map? covering;
  dynamic? machine;
  String checking;

  // int pendingOrders;

  JobOrderDetail(
      {required this.id,
      required this.date,
      required this.order,
      required this.jobOrderNo,
      required this.status,
      required this.customer,
      required this.elastics,
      required this.shiftDetails,
      this.covering,
      this.warping,
      this.machine,
      required this.checking});

  factory JobOrderDetail.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'customer': String cus,
        'jobOrderNo': String jobOrderNo,
        'date': String date,
        'status': String status,
        'shiftDetails': List shiftDetails,
        'order': String order,
        'elastics': List elastics,
        'warping': dynamic warping,
        'covering': dynamic covering,
        'machine': dynamic machine,
        'checking': String c
      } =>
        JobOrderDetail(
            id: id,
            date: DateTime.parse(date),
            jobOrderNo: jobOrderNo.toString(),
            order: order,
            status: status,
            customer: cus,
            elastics: elastics,
            shiftDetails: shiftDetails,
            warping: (warping == "Not Assigned" ? null : warping),
            covering: (covering == "Not Assigned" ? null : covering),
            machine: (machine == "Not Assigned" ? "Notassigned" : machine),
            checking: (c == "Not Assigned" ? "Notassigned" : c)),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
