import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class GetDiscoverFeed extends UseCase<List<Look>, NoParams> {
  final HomeRepository repository;

  GetDiscoverFeed(this.repository);

  @override
  Future<List<Look>> call(NoParams params) {
    return repository.getDiscoverFeed();
  }
}