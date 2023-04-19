import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/Page/PaymentPage.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../API/api.dart';
import '../model/Order.dart';
import '../model/Product.dart';

class CartPage extends StatefulWidget {
  final UserLogin userLogin;

  const CartPage({required this.userLogin});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Order> orderListTmp = [];
  late List<Order> orderList = [];
  late List<Product> productList = [];
  late Product product = Product();
  List<bool> _isCheckedList = [];
  void showDeleteAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xóa sản phẩm"),
          content: Text("Bạn có chắc chắn muốn xóa sản phẩm này?"),
          actions: [
            TextButton(
              child: Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Xóa"),
              onPressed: () {
                setState(() {
                  DeleteOrderbyId(orderList[index].orderId!.toInt(),
                      widget.userLogin.token.toString());
                  orderList.removeAt(index);
                  _isCheckedList.remove(index);
                  print(_isCheckedList);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getListOrderToAPI(
            widget.userLogin.id!.toInt(), widget.userLogin.token.toString())
        .then((value) {
      setState(() {
        orderListTmp = value;
      });
      print('orderListTmp  = $orderListTmp');
      for (Order order in orderListTmp)
        if (order.orderStatus == 'CART') orderList.add(order);
      for (int i = 0; i < orderList.length; i++) _isCheckedList.add(false);
      print('orderList  = $orderList');
    });
    getListProductToAPI(widget.userLogin.token.toString()).then((value) {
      setState(() {
        productList = value;
      });
      // print(productListNewProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: myColors.appBar,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                for (Product pro in productList) {
                  if (pro.productId.toString() ==
                      orderList[index].orderDetails!.keys.first) {
                    product = pro;
                  }
                }
                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _isCheckedList[index],
                        onChanged: (value) {
                          setState(() {
                            _isCheckedList[index] = value!;
                            print(_isCheckedList);
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            showDeleteAlertDialog(context, index);
                          });
                          // Xử lý sự kiện khi người dùng bấm nút xóa
                        },
                      ),
                    ],
                  ),
                  title: Text(product.productName.toString()),
                  subtitle: Text(
                      '${orderList[index].orderDetails!.values.first} x ${product.productPrice}'),
                  leading:
                      product.imageUrls != null && product.imageUrls!.isNotEmpty
                          ? Image.network(product.imageUrls![0].toString())
                          : SizedBox(),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: 50,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                print(_isCheckedList);
                bool _ischeck = false;
                for (bool ok in _isCheckedList) if (ok) _ischeck = true;
                if (!_ischeck)
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Vui lòng chọn sản phẩm'),
                    duration: Duration(seconds: 2),
                  ));
                else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentPage(
                            userLogin: widget.userLogin,
                            isCheckedList: _isCheckedList,
                            orderList: orderList,
                            productList: productList,
                          )));
                }
                // gọi hàm POST ORDE
              },
              child: Text(
                'Thanh Toán',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
