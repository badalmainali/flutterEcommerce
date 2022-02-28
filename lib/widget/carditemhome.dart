import 'package:ecommerce/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../contributor.dart';

Widget cardItemHome(Product product,BuildContext context){
  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 40),
    child: SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  //image: NetworkImage(product.imageUrl),
                  image: FileImage(product.productImage),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: 9.0,
                      color: kTextLightColor,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: RaisedButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          6.0,
                        ),
                      ),
                      onPressed: () {
                        //Add Product to cart
                      },
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

