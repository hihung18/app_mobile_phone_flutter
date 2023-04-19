import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/Page/ProductDetail.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../model/Product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imageUrls![0]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Text(
                product.productName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Text(
                '\$${product.productPrice}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridProduct extends StatelessWidget {
  final List<Product>? productList;
  final UserLogin userLogin;
  const GridProduct(
      {Key? key, required this.productList, required this.userLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 7,
          mainAxisSpacing: 7,
        ),
        itemCount: productList?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    product: productList![index],
                    userLogin: userLogin,
                  ),
                ),
              );
            },
            child: ProductItem(product: productList![index]),
          );
        },
      ),
    );
  }
}
