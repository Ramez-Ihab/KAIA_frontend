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
    this.isFavorited = false,
  });

  Brand copyWith({
    String? name,
    String? initials,
    Country? country,
    List<BrandCategory>? categories,
    String? websiteUrl,
    List<Country>? shipsTo,
    bool? isFavorited,
  }) {
    return Brand(
      name: name ?? this.name,
      initials: initials ?? this.initials,
      country: country ?? this.country,
      categories: categories ?? this.categories,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      shipsTo: shipsTo ?? this.shipsTo,
      isFavorited: isFavorited ?? this.isFavorited,
    );
  }
}
