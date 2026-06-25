import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class GetFeaturedLook extends UseCase<Look, NoParams> {
  final HomeRepository repository;

  GetFeaturedLook(this.repository);

  @override
  Future<Look> call(NoParams params) {
    return repository.getFeaturedLook();
  }
}