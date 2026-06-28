import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/search/data/datasources/search_local_data_source.dart';
import 'package:kaia/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource dataSource;

  SearchRepositoryImpl({required this.dataSource});

  @override
  Future<List<Brand>> searchByText(String query) => dataSource.searchByText(query);

  @override
  Future<List<Look>> searchByImage(String imagePath) =>
      dataSource.searchByImage(imagePath);

  @override
  Future<List<String>> getRecentSearches() => dataSource.getRecentSearches();

  @override
  Future<void> saveRecentSearch(String query) => dataSource.saveRecentSearch(query);

  @override
  Future<void> removeRecentSearch(String query) =>
      dataSource.removeRecentSearch(query);

  @override
  Future<void> clearRecentSearches() => dataSource.clearRecentSearches();
}
