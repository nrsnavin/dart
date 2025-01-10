import 'dart:developer';

class WarpingDetail {
  String id;
  String status;
  DateTime date;
  List elastics;
  DateTime completedDate;
  String closedBy;
  String job;
  // int pendingOrders;

  WarpingDetail(
      {required this.id,
      required this.date,
      required this.status,
      required this.elastics,
      required this.job,
      required this.closedBy,
      required this.completedDate});

  factory WarpingDetail.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'date': String date,
        'status': String status,
        'elasticOrdered': List elastics,
        'completedDate': String completedDate,
        'closedBy': dynamic closedBy,
        'job': Map job
      } =>
        WarpingDetail(
            id: id,
            date: DateTime.parse(date),
            completedDate: DateTime.parse(completedDate),
            closedBy: closedBy.runtimeType==Map ?closedBy['name'].toString():closedBy.toString(),
            job: job['jobOrderNo'].toString(),
            elastics: elastics,
            status: status),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
