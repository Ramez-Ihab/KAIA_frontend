import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/search/domain/repositories/search_repository.dart';

class GetRecentSearches extends UseCase<List<String>, NoParams> {
  final SearchRepository repository;

  GetRecentSearches(this.repository);

  @override
  Future<List<String>> call(NoParams params) {
    return repository.getRecentSearches();
  }
}