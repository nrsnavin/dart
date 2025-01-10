import 'dart:developer';

class Customer {
  String? id;
  String? name;
  String? status;
  // int pendingOrders;

  Customer( { this.id,  this.name, this.status});

  // Customer.fromJson(Map<String, dynamic> json) {
  //
  //   id = json['_id'].toString();
  //   name = json['name'].toString();
  //   status = json['status'].toString();
  //
  // }



  factory Customer.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      '_id': String id,
      'name': String name,
      'status': String status,
      } =>
          Customer(
            id: id,
            name: name,
            status: status,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}