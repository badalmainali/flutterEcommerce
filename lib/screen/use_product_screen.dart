import 'package:ecommerce/requests/productRequests.dart';
import 'package:ecommerce/widget/drawer.dart';
import 'package:ecommerce/widget/user_Product_Item.dart';
import 'package:flutter/material.dart';
import './add_edit_screen.dart';


class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';
  @override
  _UserProductsScreenState createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  var products;
  @override
  void initState() {
    products=ProductRequests().getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(87, 87, 243, 1),
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(add_edit_screen.routeName);
            },
          ),
        ],
      ),
      drawer: drawer(),
      body:products==null?Center(
        child: const Text(' no product , start adding some!'),
      ):Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => Column(
            children: [
              UserProductItem(
                products[index].name,
                products[index].price,
                products[index].productImage,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
