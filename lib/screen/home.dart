import 'package:ecommerce/requests/orderRequests.dart';
import 'package:ecommerce/requests/productRequests.dart';
import 'package:ecommerce/screen/cart_screen.dart';
import 'package:ecommerce/screen/product_screen.dart';
import 'package:ecommerce/widget/badge.dart';
import 'package:ecommerce/widget/card_last_home.dart';
import 'package:ecommerce/widget/cardhome.dart';
import 'package:ecommerce/widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var products;
  var orders;
  @override
  void initState() {
    products=ProductRequests().getProducts();
    orders=OrderRequests().getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = Color.fromRGBO(87, 87, 243, 1);
    return Scaffold(
      key: _key,
      drawerScrimColor: Colors.black,
      drawer: drawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(70),
                        bottomRight: const Radius.circular(70),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _key.currentState.openDrawer();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 30,
                        ),
                        onPressed: () {},
                        color: Colors.white,
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
                      ),context,orders),

                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Image.network(
                          "https://c.top4top.io/p_18045nrfk1.png",
                          height: MediaQuery.of(context).size.height / 8.05,
                        ),
                      ),
                    ],
                  ),
                ),
                cardhome(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "New Arrivals",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(product_screen.routeName);
                          },
                          color: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 260.0,
                    child:ListView.builder(
                            itemCount: products.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context,index) {
                          return cardLastHome(products[index],context);
                        },
                        ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
