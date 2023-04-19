import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/Order.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../API/api.dart';
import '../items/ProductItem.dart';
import '../model/Product.dart';
import 'AverageProduct.dart';
import 'CartPage.dart';
import 'CheapsProduct.dart';
import 'ExpensiveProduct.dart';
import 'Login.dart';
import 'OrderPage.dart';

class MyHomePage extends StatefulWidget {
  final UserLogin userLogin;
  const MyHomePage({required this.userLogin});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String> images = [
  'http://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-Le-hoi-phu-kien-800-300.png',
  'https://cdn1.hoanghamobile.com/tin-tuc/wp-content/uploads/2020/07/banner-trang-tin-sale.jpg',
  'http://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-HC-Tra-Gop-800-300.png',
  'http://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-big-ky-nguyen-800-300.jpg'
];
final bannerImage = CarouselSlider(
  options: CarouselOptions(
    autoPlay: true,
    enlargeCenterPage: true,
    viewportFraction: 0.9,
  ),
  items: images.map((image) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }).toList(),
);

class _MyHomePageState extends State<MyHomePage> {
  late List<Product> productList = [];
  late List<Product> productListNewProduct = [];
  late List<Product> productListCheaps = [];
  late List<Product> productListAverage = [];
  late List<Product> productListExpensive = [];

  @override
  void initState() {
    super.initState();
    getListProductToAPI(widget.userLogin.token.toString()).then((value) {
      setState(() {
        productList = value;
        var random = Random();
        List<Product> productListNEW = [];
        productListNEW.addAll(productList);
        for (int i = 0; i < 6; i++) {
          int randomIndex = random.nextInt(productListNEW.length);
          if (productListNEW[randomIndex].productId!.toInt() > 40) {
            i--;
            continue;
          }
          productListNewProduct.add(productListNEW[randomIndex]);
          productListNEW.remove(randomIndex);
        }
        print(productListNewProduct);
        for (Product product in productList) {
          if (product.cateId == 1) productListCheaps.add(product);
          if (product.cateId == 2) productListAverage.add(product);
          if (product.cateId == 3) productListExpensive.add(product);
        }
      });
      // print(productListNewProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.background,
      appBar: AppBar(
        title: Text('LEZADA'),
        backgroundColor: myColors.appBar,
      ),
      body: Column(
        children: [
          bannerImage,
          Text(
            'New Product',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          GridProduct(
            productList: productListNewProduct,
            userLogin: widget.userLogin,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyHomePage(userLogin: widget.userLogin),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.smartphone_outlined),
              title: const Text('Cheaps Product'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CheapsProduct(
                          productListCheaps: productListCheaps,
                          userLogin: widget.userLogin,
                        )));
              },
            ),
            ListTile(
              leading: Icon(Icons.smartphone_outlined),
              title: const Text('Average Product'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AverageProduct(
                          productListAverage: productListAverage,
                          userLogin: widget.userLogin,
                        )));
              },
            ),
            ListTile(
              leading: Icon(Icons.smartphone_outlined),
              title: const Text('Expensive Product'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ExpensiveProduct(
                          productListExpensive: productListExpensive,
                          userLogin: widget.userLogin,
                        )));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        CartPage(userLogin: widget.userLogin)));
              },
            ),
            ListTile(
              leading: Icon(Icons.payment_outlined),
              title: const Text('Order'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderPage(
                          userLogin: widget.userLogin,
                          productList: productList,
                        )));
              },
            ),
            const Divider(
              color: Colors.blueAccent,
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
