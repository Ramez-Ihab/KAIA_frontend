import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';

abstract class SearchLocalDataSource {
  Future<List<Brand>> searchByText(String query);
  Future<List<Look>> searchByImage(String imagePath);
  Future<List<String>> getRecentSearches();
  Future<void> saveRecentSearch(String query);
  Future<void> removeRecentSearch(String query);
  Future<void> clearRecentSearches();
}

class FakeSearchLocalDataSource implements SearchLocalDataSource {
  final List<String> _recentSearches = [];

  static const List<Brand> _searchableBrands = [
    Brand(name: '1309 Studios', initials: '1S', country: Country.qatar, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.qatar]),
    Brand(name: '6901 Cairo', initials: '6C', country: Country.egypt, categories: [BrandCategory.womenswear, BrandCategory.menswear], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Anut Cairo', initials: 'AC', country: Country.egypt, categories: [BrandCategory.homeAccessories], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Baynoire', initials: 'BA', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Dalya', initials: 'DA', country: Country.egypt, categories: [BrandCategory.womenswear, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Emergency Room Beirut', initials: 'ER', country: Country.lebanon, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.lebanon]),
    Brand(name: 'Irth Jewels', initials: 'IJ', country: Country.uae, categories: [BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.uae]),
    Brand(name: "L\'Afshar", initials: 'LA', country: Country.egypt, categories: [BrandCategory.bags], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Nada Debs', initials: 'ND', country: Country.lebanon, categories: [BrandCategory.homeAccessories], websiteUrl: '', shipsTo: [Country.lebanon]),
    Brand(name: 'Okhtein', initials: 'OK', country: Country.egypt, categories: [BrandCategory.bags, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Rebel Cairo', initials: 'RC', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]),
    Brand(name: 'Reemami', initials: 'RE', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]),
  ];

  @override
  Future<List<Brand>> searchByText(String query) async {
    if (query.isEmpty) return [];
    return _searchableBrands
        .where((b) => b.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<Look>> searchByImage(String imagePath) async => [];

  @override
  Future<List<String>> getRecentSearches() async => List.from(_recentSearches);

  @override
  Future<void> saveRecentSearch(String query) async {
    _recentSearches.remove(query);
    _recentSearches.insert(0, query);
  }

  @override
  Future<void> removeRecentSearch(String query) async => _recentSearches.remove(query);

  @override
  Future<void> clearRecentSearches() async => _recentSearches.clear();
}
