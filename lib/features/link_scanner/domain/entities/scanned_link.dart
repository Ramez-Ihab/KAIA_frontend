// lib/features/link_scanner/domain/entities/scanned_link.dart

import 'package:kaia/core/entities/brand.dart';

class ScannedLink {
  final String url;
  final Brand identifiedBrand;
  final List<Brand> similarBrands;

  const ScannedLink({
    required this.url,
    required this.identifiedBrand,
    required this.similarBrands,
  });
}