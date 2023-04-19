import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../items/ProductItem.dart';
import '../model/Product.dart';

class ExpensiveProduct extends StatefulWidget {
  final List<Product> productListExpensive;
  final UserLogin userLogin;
  const ExpensiveProduct(
      {required this.productListExpensive, required this.userLogin});

  @override
  State<ExpensiveProduct> createState() => _ExpensiveProductState();
}

class _ExpensiveProductState extends State<ExpensiveProduct> {
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
            productList: widget.productListExpensive,
            userLogin: widget.userLogin,
          )
        ],
      ),
    );
  }
}
