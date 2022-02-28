import 'package:ecommerce/requests/productRequests.dart';
import 'package:ecommerce/widget/ItemProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../contributor.dart';

class Bodyhome extends StatefulWidget {
  @override
  _BodyhomeState createState() => _BodyhomeState();
}

class _BodyhomeState extends State<Bodyhome> {
  var products;
  @override
  void initState() {
    products= ProductRequests().getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: kDefaultPaddin,
          crossAxisSpacing: 10,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (context, i) =>itemProduct(context, products[i]),
      ),
    );
  }
}
