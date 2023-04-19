import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_moblie_phone_flutter/Page/OrderDetail.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../API/api.dart';
import '../model/Order.dart';
import '../model/Product.dart';

class OrderPage extends StatefulWidget {
  final UserLogin userLogin;
  final List<Product> productList;
  const OrderPage({required this.userLogin, required this.productList});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late List<Order> orderListTmp = [];
  late List<Order> orderList = [];
  @override
  void initState() {
    super.initState();
    getListOrderToAPI(
            widget.userLogin.id!.toInt(), widget.userLogin.token.toString())
        .then((value) {
      setState(() {
        orderListTmp = value;
      });
      for (Order order in orderListTmp)
        if (order.orderStatus.toString() != 'CART') {
          orderList.add(order);
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
        backgroundColor: myColors.appBar,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(
                        userLogin: widget.userLogin,
                        productList: widget.productList,
                        order: orderList[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 176, 36, 36)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Order ID: ' +
                                  orderList[index].orderId.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('User Name: ' +
                                widget.userLogin.fullName.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('PhoneNumber: ' +
                                orderList[index].orderPhone.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Adress: ' +
                                orderList[index].orderAddress.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Number Product: ' +
                                orderList[index]
                                    .orderDetails!
                                    .length
                                    .toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Order Status: ' +
                                  orderList[index].orderStatus.toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
