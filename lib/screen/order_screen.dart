import 'package:ecommerce/requests/orderRequests.dart';
import 'package:ecommerce/widget/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class order_screen extends StatefulWidget {
  static const routeName = '/Order';

  @override
  _order_screenState createState() => _order_screenState();
}

class _order_screenState extends State<order_screen> {
  var orders;
  @override
  void initState() {
    orders=OrderRequests().getOrders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(87, 87, 243, 1),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => order_item(orders[index]),
        itemCount: orders.length,
      ),
    );
  }
}
