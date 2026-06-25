import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/entities/brand.dart';
abstract class SearchRepository {
  Future<List<Brand>> searchByText(String query);
  Future<List<Look>> searchByImage(String imagePath);
  Future<List<String>> getRecentSearches();
  Future<void> saveRecentSearch(String query);
  Future<void> removeRecentSearch(String query);
  Future<void> clearRecentSearches();
}