import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/constants/country.dart';
abstract class BrandRepository {
  Future<List<Brand>> getBrands(Country? countryFilter);
  Future<Brand> getBrandDetail(String brandId);
  Future<void> toggleFavorite(String brandId);
  Future<List<Brand>> getFavoriteBrands();
}