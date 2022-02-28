import 'package:ecommerce/model/order.dart';
import 'package:flutter/material.dart';


Widget Badge (Widget child,BuildContext context,Order orders){
  return Stack(
    alignment: Alignment.center,
    children: [
      child,
      Positioned(
        right: 8,
        top: 8,
        child: Container(
          padding: EdgeInsets.all(2.0),
          // color: Theme.of(context).accentColor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color : Theme.of(context).accentColor,
          ),
          constraints: BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: Text(
            orders.product,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      )
    ],
  );
}

