import 'package:ecommerce/requests/orderRequests.dart';
import 'package:ecommerce/screen/cart_screen.dart';
import 'package:ecommerce/widget/Product.dart';
import 'package:ecommerce/widget/badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum FilterOptions {
  Favorites,
  All,
}

class product_screen extends StatefulWidget {
  static const routeName = '/product';
  @override
  _product_screenState createState() => _product_screenState();
}

class _product_screenState extends State<product_screen> {
  var _showOnlyFavorites = false;
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
        title: Text("Your Product"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(87, 87, 243, 1),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Badge(IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(CartScreen.routeName);
            },
            color: Colors.white,
          ), context, orders),
        ],
      ),
      body: Bodyhome(),
    );
  }
}
