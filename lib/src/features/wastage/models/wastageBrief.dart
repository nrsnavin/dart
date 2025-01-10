class WastageBrief {
  String date;
  int wastage;

  WastageBrief({required this.date, required this.wastage});

  factory WastageBrief.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'date': String date,
        'quantity': int wastage,
      } =>
        WastageBrief(date: date, wastage: wastage),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
