import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/search/domain/repositories/search_repository.dart';

class ClearRecentSearches extends UseCase<void, NoParams> {
  final SearchRepository repository;

  ClearRecentSearches(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.clearRecentSearches();
  }
}