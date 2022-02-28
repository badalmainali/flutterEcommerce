import 'dart:math';
import 'package:ecommerce/model/order.dart';
import 'package:ecommerce/requests/orderRequests.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class order_item extends StatefulWidget {
  Order order;
  order_item(this.order);
  @override
  _order_itemState createState() => _order_itemState();
}

class _order_itemState extends State<order_item> {
  var orders ;
  @override
  void initState() {
    orders = OrderRequests().getOrders();
    super.initState();
  }
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.quantity}'),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(orders.length * 20.0 + 10, 100),
              child: ListView(
                children: orders
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            prod.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${prod.quantity}x \$${prod.pric}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
