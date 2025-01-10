class ShiftOpenListModel {
  String id;
  String employee;
  String machine;
  String date;
  String shift;
  String job;

  ShiftOpenListModel(
      {required this.id,
      required this.employee,
      required this.machine,
      required this.job,
      required this.shift,
      required this.date});

  factory ShiftOpenListModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'date': String date,
        'employee': Map emp,
        'machine': Map machine,
        'job': Map job,
        'shift': String shift
      } =>
        ShiftOpenListModel(
            id: id,
            employee: emp['name'],
            date: date,
            job: job['jobOrderNo'].toString(),
            machine: machine['ID'],
            shift: shift),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
