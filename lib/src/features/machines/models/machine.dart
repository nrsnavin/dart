class MachineList {
  String id;
  String ID;
  String manufacturer;
  int jacquardHooks;
  int heads;
  int order;
  String status;

  MachineList(
      {required this.id,
      required this.ID,
      required this.status,
      required this.manufacturer,
      required this.jacquardHooks,
      required this.heads,
      required this.order});

  factory MachineList.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'ID': String ID,
        'manufacturer': String manufacturer,
        'NoOfHead': int NoOfHead,
        'NoOfHooks': int NoOfHooks,
        'orderRunning': dynamic order,
        'status': dynamic status
      } =>
        MachineList(
            id: id,
            ID: ID,
            manufacturer: manufacturer,
            heads: NoOfHead,
            jacquardHooks: NoOfHooks,
            status: status,
            order:
                order != null ? int.parse(order['jobOrderNo'].toString()) : 0),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
