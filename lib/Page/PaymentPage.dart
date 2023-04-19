import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/API/api.dart';
import 'package:app_moblie_phone_flutter/Page/MyHomePage.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../model/Order.dart';
import '../model/Product.dart';

class PaymentPage extends StatefulWidget {
  final UserLogin userLogin;
  final List<Order> orderList;
  final List<bool> isCheckedList;
  final List<Product> productList;
  const PaymentPage({
    required this.userLogin,
    required this.orderList,
    required this.isCheckedList,
    required this.productList,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isPayWhenReceive = true;
  final List<Order> orderListPayment = [];
  Product product = Product();
  int totalPrice = 0;

  final TextEditingController _addressCon = TextEditingController();
  final TextEditingController _phoneCon = TextEditingController();

  @override
  void initState() {
    for (int i = 0; i < widget.isCheckedList.length; i++)
      if (widget.isCheckedList[i]) orderListPayment.add(widget.orderList[i]);
    for (int i = 0; i < orderListPayment.length; i++) {
      for (Product pro in widget.productList) {
        if (pro.productId.toString() ==
            orderListPayment[i].orderDetails!.keys.first) {
          product = pro;
          totalPrice += orderListPayment[i].orderDetails!.values.first *
              product.productPrice!.toInt();
        }
      }
    }
  }

  void PostOrderSuccessAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Add Order Success"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MyHomePage(userLogin: widget.userLogin)));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: myColors.appBar,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: orderListPayment.length,
                      itemBuilder: (context, index) {
                        for (Product pro in widget.productList) {
                          if (pro.productId.toString() ==
                              orderListPayment[index]
                                  .orderDetails!
                                  .keys
                                  .first) {
                            product = pro;
                          }
                        }
                        return ListTile(
                          title: Text(
                            product.productName.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${orderListPayment[index].orderDetails!.values.first} x ${product.productPrice} \$',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: product.imageUrls != null &&
                                  product.imageUrls!.isNotEmpty
                              ? Image.network(product.imageUrls![0].toString())
                              : SizedBox(),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Total: $totalPrice \$',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin khách hàng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '     ' + widget.userLogin.fullName.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _phoneCon,
                        style: TextStyle(fontSize: 10),
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _addressCon,
                        style: TextStyle(fontSize: 10),
                        decoration: InputDecoration(
                          labelText: 'Địa chỉ',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phương thức thanh toán',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                CheckboxListTile(
                  title: Text(
                    'Thanh toán khi nhận hàng',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: _isPayWhenReceive,
                  onChanged: (newValue) {
                    setState(() {
                      _isPayWhenReceive = newValue!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(
                    'Thanh toán trực tuyến',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: !_isPayWhenReceive,
                  onChanged: (newValue) {
                    setState(() {
                      _isPayWhenReceive = !newValue!;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: 30,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      String _address = _addressCon.text.toString().trim();
                      String _phone = _phoneCon.text.toString().trim();
                      if (_phone.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please enter phone number'),
                          duration: Duration(seconds: 2),
                        ));
                      } else if (_address.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please enter your address'),
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        Order newOrder = Order();
                        newOrder.userId = widget.userLogin.id;
                        newOrder.orderPhone = _phone;
                        newOrder.orderAddress = _address;
                        newOrder.orderStatus = 'PREPARE';
                        newOrder.orderTime = '';
                        newOrder.orderDetails = {};
                        for (int i = 0; i < orderListPayment.length; i++) {
                          newOrder.orderDetails!
                              .addAll(orderListPayment[i].orderDetails!);
                        }
                        print('newOrder = $newOrder');
                        PostNewOrder(
                            newOrder, widget.userLogin.token.toString());
                        for (Order order in orderListPayment) {
                          DeleteOrderbyId(order.orderId!,
                              widget.userLogin.token.toString());
                        }
                        PostOrderSuccessAlertDialog(context);
                      }

                      // gọi hàm POST ORDE
                    },
                    child: Text(
                      'Đặt Hàng',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class ListProductOrder extends StatefulWidget {
//   final UserLogin userLogin;
//   final List<Order> orderList;
//   final List<bool> isCheckedList;
//   final List<Product> productList;
//   const ListProductOrder({
//     required this.userLogin,
//     required this.orderList,
//     required this.isCheckedList,
//     required this.productList,
//   });

//   @override
//   State<ListProductOrder> createState() => _ListProductOrderState();
// }

// class _ListProductOrderState extends State<ListProductOrder> {
//   final List<Order> orderListPayment = [];
//   Product product = Product();
//   int totalPrice = 0;
//   @override
//   void initState() {
//     for (int i = 0; i < widget.isCheckedList.length; i++)
//       if (widget.isCheckedList[i]) orderListPayment.add(widget.orderList[i]);
//     for (int i = 0; i < orderListPayment.length; i++) {
//       for (Product pro in widget.productList) {
//         if (pro.productId.toString() ==
//             orderListPayment[i].orderDetails!.keys.first) {
//           product = pro;
//           totalPrice += orderListPayment[i].orderDetails!.values.first *
//               product.productPrice!.toInt();
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: orderListPayment.length,
//             itemBuilder: (context, index) {
//               for (Product pro in widget.productList) {
//                 if (pro.productId.toString() ==
//                     orderListPayment[index].orderDetails!.keys.first) {
//                   product = pro;
//                 }
//               }
//               return ListTile(
//                 title: Text(
//                   product.productName.toString(),
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   '${orderListPayment[index].orderDetails!.values.first} x ${product.productPrice} \$',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 leading:
//                     product.imageUrls != null && product.imageUrls!.isNotEmpty
//                         ? Image.network(product.imageUrls![0].toString())
//                         : SizedBox(),
//               );
//             },
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               'Total: $totalPrice \$',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// class btnDatHang extends StatelessWidget {
//   const btnDatHang({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//           height: 30,
//           width: 200,
//           child: ElevatedButton(
//             onPressed: () {
//               // gọi hàm POST ORDE
//             },
//             child: Text(
//               'Đặt Hàng',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class UserInfor extends StatefulWidget {
//   final UserLogin userLogin;
//   const UserInfor({required this.userLogin});

//   @override
//   State<UserInfor> createState() => _UserInforState();
// }

// class _UserInforState extends State<UserInfor> {
//   final _formKey = GlobalKey<FormState>();
//   String _address = '';
//   String _phone = '';
//   void initState() {
//     super.initState();
//     print(widget.userLogin.fullName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Thông tin khách hàng',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//         Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '     ' + widget.userLogin.fullName.toString(),
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 style: TextStyle(fontSize: 10),
//                 decoration: InputDecoration(
//                   labelText: 'Số điện thoại',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Vui lòng nhập số điện thoại';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   setState(() {
//                     _phone = value!;
//                   });
//                 },
//               ),
//               SizedBox(height: 10),
//               TextFormField(
//                 style: TextStyle(fontSize: 10),
//                 decoration: InputDecoration(
//                   labelText: 'Địa chỉ',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Vui lòng nhập địa chỉ';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   setState(() {
//                     _address = value!;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         PaymentMethod(),
//         btnDatHang(formKey: _formKey),
//       ],
//     );
//   }
// }

// class PaymentMethod extends StatefulWidget {
//   const PaymentMethod({super.key});

//   @override
//   State<PaymentMethod> createState() => _PaymentMethodState();
// }

// class _PaymentMethodState extends State<PaymentMethod> {
//   bool _isPayWhenReceive = true;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Phương thức thanh toán',
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//         CheckboxListTile(
//           title: Text(
//             'Thanh toán khi nhận hàng',
//             style: TextStyle(fontSize: 12),
//           ),
//           value: _isPayWhenReceive,
//           onChanged: (newValue) {
//             setState(() {
//               _isPayWhenReceive = newValue!;
//             });
//           },
//         ),
//         CheckboxListTile(
//           title: Text(
//             'Thanh toán trực tuyến',
//             style: TextStyle(fontSize: 12),
//           ),
//           value: !_isPayWhenReceive,
//           onChanged: (newValue) {
//             setState(() {
//               _isPayWhenReceive = !newValue!;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }

