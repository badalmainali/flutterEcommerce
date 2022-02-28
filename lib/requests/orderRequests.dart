import 'dart:convert';
import 'package:ecommerce/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderRequests{
  Future<Map<String,dynamic>> addNewOrder (Order order) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final http.Response response = await http.post(
      'http://10.0.2.2:3000/order',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization':token
      },
      body: jsonEncode(<String, dynamic>{
        '_id': order.id,
        'product':order.product,
        'quantity':order.quantity
      }),
    );
    var result = jsonDecode(response.body);
    print(result);
    return result;
  }

  Future<Order> getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.get('http://10.0.2.2:3000/order',headers:<String, String>{
      'authorization':token
    } );
    try {
      return Order.fromJson(jsonDecode(response.body));
    } catch(ex) {
      print('error with get orders ${ex}');
    }
  }

  Future<Order> deleteOrders(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.delete('http://10.0.2.2:3000/order/${id}',headers:<String, String>{
      'authorization':token
    } );
    try {
      return Order.fromJson(jsonDecode(response.body));
    } catch(ex) {
      print('error in delete orders ${ex}');
    }
  }
}
