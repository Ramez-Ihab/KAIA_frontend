import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/search/domain/repositories/search_repository.dart';

class SaveRecentSearch extends UseCase<void, String> {
  final SearchRepository repository;

  SaveRecentSearch(this.repository);

  @override
  Future<void> call(String query) {
    return repository.saveRecentSearch(query);
  }
}