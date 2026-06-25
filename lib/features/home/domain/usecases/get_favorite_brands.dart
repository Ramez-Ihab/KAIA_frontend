import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/features/home/domain/repositories/brand_repository.dart';

class GetFavoriteBrands extends UseCase<List<Brand>, NoParams> {
  final BrandRepository repository;

  GetFavoriteBrands(this.repository);

  @override
  Future<List<Brand>> call(NoParams params) {
    return repository.getFavoriteBrands();
  }
}