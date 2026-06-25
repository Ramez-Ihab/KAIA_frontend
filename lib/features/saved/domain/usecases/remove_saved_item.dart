import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/saved/domain/repositories/saved_repository.dart';

class RemoveSavedItem extends UseCase<void, String> {
  final SavedRepository repository;

  RemoveSavedItem(this.repository);

  @override
  Future<void> call(String itemId) {
    return repository.removeItem(itemId);
  }
}