import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/features/home/domain/repositories/brand_repository.dart';

class GetBrandDetail extends UseCase<Brand, String> {
  final BrandRepository repository;

  GetBrandDetail(this.repository);

  @override
  Future<Brand> call(String brandId) {
    return repository.getBrandDetail(brandId);
  }
}