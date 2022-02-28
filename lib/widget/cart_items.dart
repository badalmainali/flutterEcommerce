import 'package:ecommerce/model/order.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/requests/orderRequests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cartItem (BuildContext context,Product product , Order order){
  Dismissible(
    key: ValueKey(order.id),
    background: Container(
      color: Theme.of(context).errorColor,
      child: Icon(
        Icons.delete,
        color: Colors.white,
        size: 40,
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
    ),
    direction: DismissDirection.endToStart,
    confirmDismiss: (direction) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text(
            'Do you want to remove the item from the cart?',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
            ),
          ],
        ),
      );
    },
    onDismissed: (direction) {
      OrderRequests().deleteOrders(order.id);
    },
    child: Card(
      child: ListTile(
        leading: Container(
          child: Image.file(product.productImage),
          //Image.network(imageUrl),
        ),
        title: Text(product.name),
        subtitle: Text("${product.price * order.quantity}"),
        trailing: Text("${order.quantity} x"),
      ),
    ),
  );
}
