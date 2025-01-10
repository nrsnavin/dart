import 'dart:developer';

class OrderDetail {
  String id;
  String? status;
  DateTime? date;
  DateTime? delDate;
  String? po;
  String? orderNo;
  String? desc;
  String? customer;
  List jobs;
  List elastics;
  List rawmaterialRequired = [];

  // int pendingOrders;

  OrderDetail(
      {required this.id,
      this.date,
      this.delDate,
      this.po,
      this.orderNo,
      this.status,
      this.desc,
      this.customer,
      required this.elastics,
      required this.jobs,
      required this.rawmaterialRequired});

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'customer': Map cus,
        'orderNo': String orderNo,
        'date': String date,
        'deliveryDate': String delDate,
        'po': String po,
        'description': String description,
        'status': String status,
        'jobs': List jobs,
        'elastics': List elastics,
        'rawmaterialRequired': List raw
      } =>
        OrderDetail(
          id: id,
          date: DateTime.parse(date),
          delDate: DateTime.parse(delDate),
          desc: description,
          orderNo: orderNo.toString(),
          po: po,
          status: status,
          customer: cus['name'],
          elastics: elastics,
          jobs: jobs,
          rawmaterialRequired: raw,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
