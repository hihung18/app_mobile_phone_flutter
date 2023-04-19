import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../items/ProductItem.dart';
import '../model/Product.dart';

class CheapsProduct extends StatefulWidget {
  final List<Product>? productListCheaps;
  final UserLogin userLogin;
  const CheapsProduct(
      {required this.productListCheaps, required this.userLogin});

  @override
  State<CheapsProduct> createState() => _CheapsProductState();
}

class _CheapsProductState extends State<CheapsProduct> {
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
            productList: widget.productListCheaps,
            userLogin: widget.userLogin,
          )
        ],
      ),
    );
  }
}
