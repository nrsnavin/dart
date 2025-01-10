import 'dart:developer';

class JobBrief {
  String id;
  String status;
  DateTime date;
  String jobOrderNo;
  String customer;

  // int pendingOrders;

  JobBrief({
    required this.id,
    required this.date,
    required this.jobOrderNo,
    required this.status,
    required this.customer,
  });

  factory JobBrief.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'customer': String cus,
        'jobOrderNo': int jobOrderNo,
        'date': String date,
        'status': String status,
      } =>
        JobBrief(
          id: id,
          date: DateTime.parse(date),
          jobOrderNo: jobOrderNo.toString(),
          status: status,
          customer: cus,
        ),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
