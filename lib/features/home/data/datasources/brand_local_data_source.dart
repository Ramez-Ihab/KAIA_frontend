import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/entities/brand.dart';

abstract class BrandLocalDataSource {
  Future<List<Brand>> getBrands(Country? countryFilter);
  Future<void> toggleFavorite(String brandName);
  Future<List<Brand>> getFavoriteBrands();
}

class FakeBrandLocalDataSource implements BrandLocalDataSource {
  // In-memory brand list with mutable favorite state
  final List<Brand> _brands = [
    Brand(name: '1309 Studios', initials: '1S', country: Country.qatar, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.qatar]),
    Brand(name: 'Nada Debs', initials: 'ND', country: Country.lebanon, categories: [BrandCategory.homeAccessories], websiteUrl: '', shipsTo: [Country.lebanon]),
    Brand(name: 'Okhtein', initials: 'OK', country: Country.egypt, categories: [BrandCategory.bags, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: true),
    Brand(name: 'Reemami', initials: 'RE', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: "L\'Afshar", initials: 'LA', country: Country.egypt, categories: [BrandCategory.bags], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Emergency Room Beirut', initials: 'ER', country: Country.lebanon, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.lebanon]),
    Brand(name: 'Irth Jewels', initials: 'IJ', country: Country.uae, categories: [BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.uae]),
    Brand(name: 'Dalya', initials: 'DA', country: Country.egypt, categories: [BrandCategory.womenswear, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Baynoire', initials: 'BA', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]),
  ];

  @override
  Future<List<Brand>> getBrands(Country? countryFilter) async {
    if (countryFilter == null) return List.from(_brands);
    return _brands.where((b) => b.country == countryFilter).toList();
  }

  @override
  Future<void> toggleFavorite(String brandName) async {
    final index = _brands.indexWhere((b) => b.name == brandName);
    if (index == -1) return;
    _brands[index] = _brands[index].copyWith(isFavorited: !_brands[index].isFavorited);
  }

  @override
  Future<List<Brand>> getFavoriteBrands() async {
    return _brands.where((b) => b.isFavorited).toList();
  }
}
