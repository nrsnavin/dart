class RawMaterial {
  String? id;
  String? name;
  String? category;
  int? price;
  String? supplier;
  dynamic stock;
  // int pendingOrders;

  RawMaterial(
      {this.id,
      this.name,
      this.category,
      this.price,
      this.supplier,
      this.stock});

  RawMaterial.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    supplier = json['supplier'];
    stock = json['stock'];
  }
}
