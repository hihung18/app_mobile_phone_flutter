import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/API/api.dart';
import 'package:app_moblie_phone_flutter/Page/CartPage.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/Feature.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../model/Order.dart';
import '../model/Product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final UserLogin userLogin;
  const ProductDetail({required this.product, required this.userLogin});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late List<Feature> featuretList = [];
  late List<Order> orderList = [];
  late int _NumberProductinCart = 0;
  late int _quality = 1;
  bool _isDescription = false;
  bool _isFeature = false;
  bool _postOrder = true;
  String _cammera = '', _ram = '', _rom = '', _brand = '';
  @override
  void initState() {
    super.initState();
    getListOrderToAPI(
            widget.userLogin.id!.toInt(), widget.userLogin.token.toString())
        .then((value) {
      setState(() {
        orderList = value;
      });
      // print('orderList = ');
      // print(orderList);
      for (Order order in orderList)
        if (order.orderStatus == 'CART') _NumberProductinCart++;
      // print('orderListCart = $_NumberProductinCart');
    });
    getListFeatureToAPI().then((value) {
      setState(() {
        featuretList = value;
      });
      for (int fea in widget.product.featureIds!) {
        for (Feature feature in featuretList) {
          if (fea == feature.featureFeatureId) {
            if (feature.featureTypeId == 1)
              _brand = feature.featureSpecific.toString();
            else if (feature.featureTypeId == 2)
              _cammera = feature.featureSpecific.toString();
            else if (feature.featureTypeId == 4)
              _ram = feature.featureSpecific.toString();
            else if (feature.featureTypeId == 7)
              _rom = feature.featureSpecific.toString();
          }
        }
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
        backgroundColor: myColors.appBar,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(
                            userLogin: widget.userLogin,
                          )));
            },
            padding: EdgeInsets.fromLTRB(0, 1, 10, 0),
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 35,
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: _NumberProductinCart == 0
                      ? SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 225, 17, 17),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12.0,
                            minHeight: 12.0,
                          ),
                          child: Text(
                            '$_NumberProductinCart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              child: Image.network(
                widget.product.imageUrls![0],
                fit: BoxFit.fitWidth,
                width: 180,
                height: 240,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            child: Text(
              widget.product.productName.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            child: Text(
              '\$${widget.product.productPrice}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(height: 20),
          QuantityPicker(
            initialValue: 1,
            onChanged: (quantity) {
              setState(() {
                _quality = quantity;
              });
            },
            product: widget.product,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isFeature = !_isFeature;
              });
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Feature",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (_isFeature)
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                'Brand: ' +
                    _brand +
                    ' Camera: ' +
                    _cammera +
                    ' RAM: ' +
                    _ram +
                    ' ROM: ' +
                    _rom,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isDescription = !_isDescription;
              });
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (_isDescription)
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                '${widget.product.productDescription}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                // gọi hàm POST ORDER
                for (Order order in orderList) {
                  if (order.orderStatus == 'CART' &&
                      order.orderDetails!.keys.first ==
                          widget.product.productId.toString()) {
                    int value = order.orderDetails![
                        order.orderDetails!.keys.first.toString()]!;

                    value += _quality;
                    order.orderDetails!
                        .remove(widget.product.productId.toString());
                    order.orderDetails!
                        .addAll({widget.product.productId.toString(): value});
                    _postOrder = false;
                    PutOrderbyId(order.orderId!.toInt(), order,
                        widget.userLogin.token.toString());
                    // print(
                    //     'Quanlity : $_quality  value $value neworder = $order');
                  }
                }
                if (_postOrder) {
                  _postOrder = true;
                  Order newOrder = Order();
                  newOrder.orderStatus = 'CART';
                  newOrder.orderPhone = '';
                  newOrder.orderAddress = '';
                  newOrder.orderTime = '';
                  newOrder.userId = widget.userLogin.id;
                  newOrder.orderDetails = {};
                  newOrder.orderDetails![widget.product.productId.toString()] =
                      _quality;
                  // print(newOrder.toJson());
                  // print('Quanlity = $_quality');
                  PostNewOrder(newOrder, widget.userLogin.token.toString());
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Add Product to Cart Success'),
                  duration: Duration(seconds: 2),
                ));
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(
                                userLogin: widget.userLogin,
                              )));
                });
              },
              child: Text(
                'Add to Cart',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class QuantityPicker extends StatefulWidget {
  final int initialValue;
  final Product product;
  final Function(int quantity) onChanged;

  const QuantityPicker(
      {Key? key,
      required this.initialValue,
      required this.onChanged,
      required this.product})
      : super(key: key);

  @override
  _QuantityPickerState createState() => _QuantityPickerState();
}

class _QuantityPickerState extends State<QuantityPicker> {
  late int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _increment() {
    setState(() {
      if (_quantity < widget.product.productRemain!.toInt()) {
        _quantity++;
        widget.onChanged(_quantity);
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        widget.onChanged(_quantity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text(
          _quantity.toString(),
          style: TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
