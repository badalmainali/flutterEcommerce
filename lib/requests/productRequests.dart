import 'dart:convert';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductRequests{
  Future<Map<String,dynamic>> addNewProduct (Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final http.Response response = await http.post(
      'http://10.0.2.2:3000/product',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':token
      },
      body: jsonEncode(<String, dynamic>{
        '_id': product.id,
        'name':product.name,
        'price':product.price,
        'productImage':product.productImage
      }),
    );
    var result = jsonDecode(response.body);
    print(result);
    return result;
  }

  Future<Product> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.get('http://10.0.2.2:3000/product',headers:<String, String>{
      'authorization':token
    } );
    try {
      return Product.fromJson(jsonDecode(response.body));
    } catch(ex) {
      print('error with get products ${ex}');
    }
  }
}
