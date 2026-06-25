import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/home/domain/repositories/brand_repository.dart';

class ToggleFavoriteBrand extends UseCase<void, String> {
  final BrandRepository repository;

  ToggleFavoriteBrand(this.repository);

  @override
  Future<void> call(String brandId) {
    return repository.toggleFavorite(brandId);
  }
}