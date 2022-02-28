class Order {
  String id;
  String product;
  int quantity;

  Order({this.id, this.product, this.quantity});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    product = json['product'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    return data;
  }
}