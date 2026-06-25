import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/features/home/domain/repositories/brand_repository.dart';

class GetBrandsList extends UseCase<List<Brand>, Country?> {
  final BrandRepository repository;

  GetBrandsList(this.repository);

  @override
  Future<List<Brand>> call(Country? countryFilter) {
    return repository.getBrands(countryFilter);
  }
}