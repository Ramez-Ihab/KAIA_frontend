import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/saved/domain/repositories/saved_repository.dart';

class ClearItemCategory extends UseCase<void, String> {
  final SavedRepository repository;

  ClearItemCategory(this.repository);

  @override
  Future<void> call(String itemId) {
    return repository.clearCategory(itemId);
  }
}