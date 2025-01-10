class ShiftDetailModel {
  String id;
  String employee;
  String machine;
  String date;
  String shift;
  String jobNo;
  String description;
  int production;
  String customer;
  List elastics;
  int noOfHooks;
  int noOfHeads;
  String status;

  ShiftDetailModel(
      {required this.id,
      required this.employee,
      required this.machine,
      required this.jobNo,
      required this.description,
      required this.customer,
      required this.production,
      required this.elastics,
      required this.shift,
      required this.date,
      required this.noOfHooks,
        required this.status,
      required this.noOfHeads});

  factory ShiftDetailModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'date': String date,
        'employee': String emp,
        'machine': String machine,
        'jobNo': String job,
        'shift': String shift,
        'description': String description,
        'production': int production,
        'customer': String customer,
        'noOfHeads': int noOfHeads,
        'noOfHooks': int noOfHooks,
        'elastics': List elastics,
      'status':String status,
      } =>
        ShiftDetailModel(
            id: id,
            employee: emp,
            date: date,
            jobNo: job,
            machine: machine,
            shift: shift,
            production: production,
            elastics: elastics,
            customer: customer,
            noOfHeads: noOfHeads,
            noOfHooks: noOfHooks,
            description: description,
          status: status

        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
