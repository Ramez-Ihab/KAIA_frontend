import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/features/search/domain/repositories/search_repository.dart';

class SearchByText extends UseCase<List<Brand>, String> {
  final SearchRepository repository;

  SearchByText(this.repository);

  @override
  Future<List<Brand>> call(String query) {
    return repository.searchByText(query);
  }
}