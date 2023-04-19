// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Order {
  int? orderId;
  int? userId;
  String? orderPhone;
  String? orderAddress;
  String? orderStatus;
  String? orderTime;
  Map<String, int>? orderDetails;
  Order({
    this.orderId,
    this.userId,
    this.orderPhone,
    this.orderAddress,
    this.orderStatus,
    this.orderTime,
    this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      userId: json['userId'],
      orderPhone: json['orderPhone'],
      orderAddress: json['orderAddress'],
      orderStatus: json['orderStatus'],
      orderTime: json['orderTime'],
      orderDetails: Map<String, int>.from(json['orderDetails'] ?? {}),
    );
  }
  @override
  String toString() {
    return 'Order(orderId: $orderId, userId: $userId, orderPhone: $orderPhone, orderAddress: $orderAddress, orderStatus: $orderStatus, orderTime: $orderTime, orderDetails: $orderDetails)';
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'orderPhone': orderPhone,
      'orderAddress': orderAddress,
      'orderStatus': orderStatus,
      'orderTime': orderTime,
      'orderDetails': orderDetails,
    };
  }
}
