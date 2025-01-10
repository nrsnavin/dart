import 'dart:developer';

class EmployeeDetailModel {
  String id;
  String name;
  String aadhar;
  int skill;
  String role;
  String department;
  int totalProduction;
  int totalWastage;
  List wastages;
  List shifts;
  double performance;
  int totalShifts;

  // int pendingOrders;

  EmployeeDetailModel(
      {required this.id,
      required this.name,
      required this.aadhar,
      required this.skill,
      required this.shifts,
      required this.wastages,
      required this.totalProduction,
      required this.performance,
      required this.totalWastage,
      required this.department,
      required this.role,
      required this.totalShifts});

  factory EmployeeDetailModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'name': String name,
        'aadhar': String aadhar,
        'skill': int skill,
        'role': String? role,
        'Department': String department,
        'performance': dynamic performance,
        'wastages': List wastages,
        'shifts': List shifts,
        'totalProduction': int totalProduction,
        'totalWastage': int totalWastage,
        'totalShifts' : int ts
      } =>
        EmployeeDetailModel(
            id: id,
            name: name,
            role: role??"genral",
            aadhar: aadhar,
            department: department,
            skill: skill,
            totalProduction: totalProduction,
            totalWastage: totalWastage,
            shifts: shifts,
            wastages: wastages,
            performance:double.parse( performance.toString()  ),
            totalShifts: ts),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
