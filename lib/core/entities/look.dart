import 'package:flutter/material.dart';
import 'package:kaia/core/entities/brand.dart';
class Look {
  final String? imageUrl;
  final String styleTag;
  final Brand brand;
  final Color? color; // temporary placeholder, remove later

  const Look({
    this.imageUrl,
    required this.styleTag,
    required this.brand,
    this.color,
  });
}