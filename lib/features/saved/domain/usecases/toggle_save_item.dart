import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/saved/domain/repositories/saved_repository.dart';

class ToggleSaveItem extends UseCase<void, Look> {
  final SavedRepository repository;

  ToggleSaveItem(this.repository);

  @override
  Future<void> call(Look look) {
    return repository.saveItem(look);
  }
}