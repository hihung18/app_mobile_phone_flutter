// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Product {
  int? productId;
  num? productPrice;
  String? productName;
  String? productDescription;
  int? cateId;
  String? categoryName;
  String? productCreateDate;
  int? productRemain;
  String? productUpDate;
  List<int>? featureIds;
  List<String>? imageUrls;
  int? quantity;
  Product({
    this.productId,
    this.productPrice,
    this.productName,
    this.productDescription,
    this.cateId,
    this.categoryName,
    this.productCreateDate,
    this.productRemain,
    this.productUpDate,
    this.featureIds,
    this.imageUrls,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      productPrice: json['productPrice'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      cateId: json['cateId'],
      categoryName: json['categoryName'],
      productCreateDate: json['productCreateDate'],
      productRemain: json['productRemain'],
      productUpDate: json['productUpDate'],
      featureIds: List<int>.from(json['featureIds']),
      imageUrls: List<String>.from(json['imageUrls']),
    );
  }

  @override
  String toString() {
    return '''Product(productId: $productId, productPrice: $productPrice,
     productName: $productName, productDescription: $productDescription, 
     cateId: $cateId, categoryName: $categoryName, productCreateDate: $productCreateDate, 
     productRemain: $productRemain, productUpDate: $productUpDate, featureIds: $featureIds, 
     imageUrls: $imageUrls)''';
  }
}
