import 'dart:io';

class Product {
  String id;
  String name;
  String price;
  File productImage;

  Product({this.name, this.price, this.productImage});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['productImage'] = this.productImage;
    return data;
  }
}