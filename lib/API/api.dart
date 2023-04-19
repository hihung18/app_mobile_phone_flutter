import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/Feature.dart';
import '../model/Order.dart';
import '../model/Product.dart';
import '../model/User.dart';

String baseUrl = 'http://192.168.1.7:8080/';

Future<Product> getProductToAPI() async {
  var url = Uri.parse(baseUrl + 'api/products/3');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final parsedJson = json.decode(response.body);
    return Product.fromJson(parsedJson);
    // Xử lý dữ liệu
    // ...
  } else {
    // Lấy dữ liệu thất bại
    throw Exception('Failed to fetch data');
  }
}

Future<List<Product>> getListProductToAPI(String token) async {
  var url = Uri.parse(baseUrl + 'api/products');
  var response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    final parsedJson = json.decode(response.body);
    List<Product> products = [];
    for (var productJson in parsedJson) {
      products.add(Product.fromJson(productJson));
    }
    return products;
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<List<Feature>> getListFeatureToAPI() async {
  var url = Uri.parse(baseUrl + 'api/features');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final parsedJson = json.decode(response.body);
    List<Feature> features = [];
    for (var featureJson in parsedJson) {
      features.add(Feature.fromJson(featureJson));
    }
    return features;
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<UserLogin> PostUserLoginToAPI(String username, String password) async {
  var url = Uri.parse(baseUrl + 'api/auth/signin');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    final parsedJson = json.decode(response.body);
    return UserLogin.fromJson(parsedJson);
    // Xử lý dữ liệu
    // ...
  } else {
    // Lấy dữ liệu thất bại
    throw Exception('getUser ERROR');
  }
}

Future<List<Order>> getListOrderToAPI(int userId, String token) async {
  var url = Uri.parse(baseUrl + 'api/orders?userId=$userId');
  var response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 200) {
    final parsedJson = json.decode(response.body);
    List<Order> order = [];
    for (var orderJson in parsedJson) {
      order.add(Order.fromJson(orderJson));
    }
    return order;
  } else {
    throw Exception('getListOrder ERROR');
  }
}

Future<void> PostNewOrder(Order order, String token) async {
  var url = Uri.parse(baseUrl + 'api/orders');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(order.toJson()),
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    final parsedJson = json.decode(response.body);
    print('PostOrder success');
    // Xử lý dữ liệu
    // ...
  } else {
    print('PostOrder ERROR: ${response.statusCode} - ${response.body}');
    // Lấy dữ liệu thất bại
    print('PostOrder ERROR: ${response.body}');
    throw Exception('PostOrder ERROR');
  }
}

Future<void> PutOrderbyId(int orderId, Order order, String token) async {
  var url = Uri.parse(baseUrl + 'api/orders/$orderId');
  var response = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(order.toJson()),
  );
  if (response.statusCode == 201 || response.statusCode == 202) {
    final parsedJson = json.decode(response.body);
    print('PutOrder success');
    // Xử lý dữ liệu
    // ...
  } else {
    print('PutOrder ERROR: ${response.statusCode} - ${response.body}');
    // Lấy dữ liệu thất bại
    print('PutOrder ERROR: ${response.body}');
    throw Exception('PutOrder ERROR');
  }
}

Future<void> DeleteOrderbyId(int orderId, String token) async {
  var url = Uri.parse(baseUrl + 'api/orders/$orderId');
  var response = await http.delete(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    },
  );
  if (response.statusCode == 201 || response.statusCode == 202) {
    final parsedJson = json.decode(response.body);
    print('DeleteOrder success');
    // Xử lý dữ liệu
    // ...
  } else {
    print('DeleteOrder ERROR: ${response.statusCode} - ${response.body}');
    // Lấy dữ liệu thất bại
    print('DeleteOrder ERROR: ${response.body}');
    throw Exception('DeleteOrder ERROR');
  }
}

Future<void> PostUserSignUp(UserSignUp userSignUp) async {
  var url = Uri.parse(baseUrl + 'api/auth/signup');
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userSignUp.toJson()),
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    final parsedJson = json.decode(response.body);
    print('Create Account success');
    // Xử lý dữ liệu
    // ...
  } else {
    print('Create Account ERROR: ${response.statusCode} - ${response.body}');
    // Lấy dữ liệu thất bại
    print('Create Account ERROR: ${response.body}');
    throw Exception('Create Account ERROR');
  }
}
