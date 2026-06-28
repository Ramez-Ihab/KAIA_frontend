import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/features/home/data/datasources/brand_local_data_source.dart';
import 'package:kaia/features/home/domain/repositories/brand_repository.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandLocalDataSource dataSource;

  BrandRepositoryImpl({required this.dataSource});

  @override
  Future<List<Brand>> getBrands(Country? countryFilter) =>
      dataSource.getBrands(countryFilter);

  @override
  Future<Brand> getBrandDetail(String brandId) async {
    final brands = await dataSource.getBrands(null);
    return brands.firstWhere((b) => b.name == brandId);
  }

  @override
  Future<void> toggleFavorite(String brandId) =>
      dataSource.toggleFavorite(brandId);

  @override
  Future<List<Brand>> getFavoriteBrands() => dataSource.getFavoriteBrands();
}
