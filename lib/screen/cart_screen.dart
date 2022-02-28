import 'package:ecommerce/requests/orderRequests.dart';
import 'package:ecommerce/requests/productRequests.dart';
import 'package:ecommerce/widget/cart_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../contributor.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/Cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var orders ;
  var products;
  @override
  void initState() {
    orders = OrderRequests().getOrders();
    products = ProductRequests().getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(87, 87, 243, 1),
        title: Text('Your Cart'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => cartItem(context,products[index],orders[index]),
            itemCount:orders.length,
          )),
          Card(
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 18, color: kTextLightColor),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${orders.quantity* products.price}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(87, 87, 243, 1),
                  ),
                  Spacer(),
                  RaisedButton(
                    color: Color.fromRGBO(87, 87, 243, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    textColor: Color.fromRGBO(87, 87, 243, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
