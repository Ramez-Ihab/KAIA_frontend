import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/home/domain/entities/featured_item.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class GetFeaturedItem extends UseCase<FeaturedItem, NoParams> {
  final HomeRepository repository;

  GetFeaturedItem(this.repository);

  @override
  Future<FeaturedItem> call(NoParams params) {
    return repository.getFeaturedItem();
  }
}
