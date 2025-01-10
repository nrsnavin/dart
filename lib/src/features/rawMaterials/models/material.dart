class MaterialModel {
  String id;
  String name;
  String category;
  double stock;
  String supplier;
  double grammage;
  int minStock;

  MaterialModel(
      {required this.id,
      required this.name,
      required this.stock,
      required this.supplier,
      required this.category,
      required this.grammage,
      required this.minStock});

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id,
        'name': String name,
        'category': String category,
        'stock': dynamic stock,
        'supplier': String supplier,
        'grammage': double grammage,
        'minStock': int minStock
      } =>
        MaterialModel(
            id: id,
            name: name,
            stock: double.parse(stock.toString()),
            category: category,
            grammage: grammage,
            supplier: supplier,
            minStock: minStock),
      _ => throw const FormatException('Failed to load Job.'),
    };
  }
}
