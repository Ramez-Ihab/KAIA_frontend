import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/saved/domain/repositories/saved_repository.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';

class CategoriseSavedItemParams {
  final String itemId;
  final SavedCategory category;

  CategoriseSavedItemParams({required this.itemId, required this.category});
}

class CategoriseSavedItem extends UseCase<void, CategoriseSavedItemParams> {
  final SavedRepository repository;

  CategoriseSavedItem(this.repository);

  @override
  Future<void> call(CategoriseSavedItemParams params) {
    return repository.categoriseItem(params.itemId, params.category);
  }
}