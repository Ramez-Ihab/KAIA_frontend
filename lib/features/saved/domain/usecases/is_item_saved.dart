import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/saved/domain/repositories/saved_repository.dart';

class IsItemSaved extends UseCase<bool, String> {
  final SavedRepository repository;

  IsItemSaved(this.repository);

  @override
  Future<bool> call(String lookId) {
    return repository.isItemSaved(lookId);
  }
}