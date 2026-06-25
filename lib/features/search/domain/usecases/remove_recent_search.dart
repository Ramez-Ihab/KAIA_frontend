import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/search/domain/repositories/search_repository.dart';

class RemoveRecentSearch extends UseCase<void, String> {
  final SearchRepository repository;

  RemoveRecentSearch(this.repository);

  @override
  Future<void> call(String query) {
    return repository.removeRecentSearch(query);
  }
}