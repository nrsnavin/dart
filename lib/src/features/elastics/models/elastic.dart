import 'dart:developer';

class Elastic {
  String? id;
  String? name;
  // int pendingOrders;

  Elastic({this.id, this.name});

  // Customer.fromJson(Map<String, dynamic> json) {
  //
  //   id = json['_id'].toString();
  //   name = json['name'].toString();
  //   status = json['status'].toString();
  //
  // }

  factory Elastic.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'name': String name,
      } =>
        Elastic(
          id: id,
          name: name,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
