import 'package:flutter/material.dart';
import 'package:kaia/core/entities/brand.dart';

class LookColor {
  final Color color;
  final String name;
  final List<String> imageUrls;
  const LookColor({required this.color, required this.name, this.imageUrls = const []});
}

class Look {
  final List<String> imageUrls;
  final String styleTag;
  final Brand brand;
  final Color? color;
  final double? price;
  final List<Look> similarLooks;
  final List<LookColor> colors;
  final List<int> sizes;

  // Cards show the first image of the first color so they match LookPage's default view
  String? get imageUrl {
    if (colors.isNotEmpty && colors.first.imageUrls.isNotEmpty) {
      return colors.first.imageUrls.first;
    }
    return imageUrls.isNotEmpty ? imageUrls.first : null;
  }

  Look copyWithUrl(String url) => Look(
        imageUrls: [url],
        styleTag: styleTag,
        brand: brand,
        color: color,
        price: price,
        similarLooks: similarLooks,
        colors: const [],
        sizes: sizes,
      );

  const Look({
    required this.imageUrls,
    required this.styleTag,
    required this.brand,
    this.color,
    this.price,
    this.similarLooks = const [],
    this.colors = const [],
    this.sizes = const [],
  });
}
