import 'dart:developer';

class Order {
  String? id;
  String? status;
  DateTime? date;
  DateTime? delDate;
  String? po;
  String? orderNo;
  String? desc;
  String? customer;

  // int pendingOrders;

  Order(
      {this.id,
      this.date,
      this.delDate,
      this.po,
      this.orderNo,
      this.status,
      this.desc,
      this.customer});

  // Customer.fromJson(Map<String, dynamic> json) {
  //
  //   id = json['_id'].toString();
  //   name = json['name'].toString();
  //   status = json['status'].toString();
  //
  // }

  factory Order.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'customer': Map cus,
        'orderNo': int orderNo,
        'date': String date,
        'supplyDate': String delDate,
        'po': String po,
        'description': String description,
        'status': String status,
      } =>
        Order(
            id: id,
            date: DateTime.parse(date),
            delDate:DateTime.parse(delDate),
            desc: description,
            orderNo: orderNo.toString(),
            po: po,
            status: status,
          customer: cus['name']

        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
