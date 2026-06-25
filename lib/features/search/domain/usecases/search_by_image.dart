import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/search/domain/repositories/search_repository.dart';

class SearchByImage extends UseCase<List<Look>, String> {
  final SearchRepository repository;

  SearchByImage(this.repository);

  @override
  Future<List<Look>> call(String imagePath) {
    return repository.searchByImage(imagePath);
  }
}