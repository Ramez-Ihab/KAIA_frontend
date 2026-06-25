import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class GetMoodCategories extends UseCase<List<String>, NoParams> {
  final HomeRepository repository;

  GetMoodCategories(this.repository);

  @override
  Future<List<String>> call(NoParams params) {
    return repository.getMoodCategories();
  }
}