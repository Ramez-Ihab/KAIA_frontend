import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class GetForYouFeed extends UseCase<List<Look>, NoParams> {
  final HomeRepository repository;

  GetForYouFeed(this.repository);

  @override
  Future<List<Look>> call(NoParams params) {
    return repository.getForYouFeed();
  }
}