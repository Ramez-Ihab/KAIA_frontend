import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/brand_category.dart';
class Brand {
  final String name;
  final String initials;
  final Country country;
  final List<BrandCategory> categories;
  final String? websiteUrl;
  final List<Country> shipsTo;
  final bool isFavorited;

  const Brand({
    required this.name,
    required this.initials,
    required this.country,
    required this.categories,
    this.websiteUrl,
    required this.shipsTo,
    this.isFavorited = false ,
  });
}