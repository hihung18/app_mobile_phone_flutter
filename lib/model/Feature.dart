// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Feature {
  int? featureFeatureId;
  int? featureTypeId;
  String? featureSpecific;
  int? featurePoint;
  Feature({
    this.featureFeatureId,
    this.featureTypeId,
    this.featureSpecific,
    this.featurePoint,
  });
  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      featureFeatureId: json['featureFeatureId'],
      featureTypeId: json['featureTypeId'],
      featureSpecific: json['featureSpecific'],
      featurePoint: json['featurePoint'],
    );
  }
  @override
  String toString() {
    return 'Feature(featureFeatureId: $featureFeatureId, featureTypeId: $featureTypeId, featureSpecific: $featureSpecific, featurePoint: $featurePoint)';
  }
}
