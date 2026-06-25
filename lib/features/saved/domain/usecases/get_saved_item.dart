import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/features/saved/domain/repositories/saved_repository.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';

class GetSavedItemsParams {
  final SavedCategory? filter;
  final SortOrder sortOrder;

  GetSavedItemsParams({this.filter, required this.sortOrder});
}

class GetSavedItems extends UseCase<List<SavedItem>, GetSavedItemsParams> {
  final SavedRepository repository;

  GetSavedItems(this.repository);

  @override
  Future<List<SavedItem>> call(GetSavedItemsParams params) {
    return repository.getSavedItems(params.filter, params.sortOrder);
  }
}