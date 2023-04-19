import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/Order.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';
import 'package:matcher/matcher.dart';

import '../model/Product.dart';

class OrderDetailPage extends StatefulWidget {
  final UserLogin userLogin;
  final List<Product> productList;
  final Order order;
  const OrderDetailPage({
    required this.userLogin,
    required this.productList,
    required this.order,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  Product product = Product();
  int key = 0;
  int value = 0;
  List<Product> productDetailList = [];
  int total = 0;
  @override
  void initState() {
    for (var entry in widget.order.orderDetails!.entries) {
      int key = int.parse(entry.key);
      int value = entry.value;
      for (Product pro in widget.productList) {
        if (pro.productId == key) {
          pro.quantity = value;
          productDetailList.add(pro);
        }
      }
      ;
    }
    for (Product product in productDetailList) {
      total += product.productPrice!.toInt() * product.quantity!.toInt();
    }
    print(total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
        backgroundColor: myColors.appBar,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Order ID: ' + widget.order.orderId.toString(),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('User Name: ' + widget.userLogin.fullName.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('PhoneNumber: ' + widget.order.orderPhone.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Adress: ' + widget.order.orderAddress.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Number Product: ' +
                  widget.order.orderDetails!.length.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Order Status: ' + widget.order.orderStatus.toString(),
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: productDetailList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    productDetailList[index].productName.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${productDetailList[index].quantity} x ${productDetailList[index].productPrice} \$',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: productDetailList[index].imageUrls != null &&
                          productDetailList[index].imageUrls!.isNotEmpty
                      ? Image.network(
                          productDetailList[index].imageUrls![0].toString())
                      : SizedBox(),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total: $total\$   ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
