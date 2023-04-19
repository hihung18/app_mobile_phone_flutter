import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../items/ProductItem.dart';
import '../model/Product.dart';

class AverageProduct extends StatefulWidget {
  final List<Product> productListAverage;
  final UserLogin userLogin;
  const AverageProduct(
      {required this.productListAverage, required this.userLogin});

  @override
  State<AverageProduct> createState() => _AverageProductState();
}

class _AverageProductState extends State<AverageProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cheap Product'),
        backgroundColor: myColors.appBar,
      ),
      body: Column(
        children: [
          GridProduct(
            productList: widget.productListAverage,
            userLogin: widget.userLogin,
          )
        ],
      ),
    );
  }
}
