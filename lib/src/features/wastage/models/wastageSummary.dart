class WastageSummary {
  String date;
  int quantity;
  String employee;
  String job;
  String elastic;
  String id;

  WastageSummary({
    required this.date,
    required this.id,
    required this.quantity,
    required this.employee,
    required this.job,
    required this.elastic,
  });

  factory WastageSummary.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'createdAt': String date,
        '_id': String id,
        'quantity': int quantity,
        'employee': Map employee,
        'job': Map job,
        'elastic': Map elastic,
      } =>
        WastageSummary(
          date: date,
          quantity: quantity,
          elastic: elastic['name'],
          job: job['jobOrderNo'].toString(),
          employee: employee['name'],
          id: id,
        ),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
