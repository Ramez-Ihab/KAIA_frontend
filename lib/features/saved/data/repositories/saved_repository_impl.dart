import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/saved/data/datasources/saved_local_data_source.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/features/saved/domain/repositories/saved_repository.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';

class SavedRepositoryImpl implements SavedRepository {
  final SavedLocalDataSource dataSource;

  SavedRepositoryImpl({required this.dataSource});

  @override
  Future<List<SavedItem>> getSavedItems(SavedCategory? filter, SortOrder sortOrder) =>
      dataSource.getSavedItems(filter, sortOrder);

  @override
  Future<void> saveItem(Look look) => dataSource.saveItem(look);

  @override
  Future<void> removeItem(String itemId) => dataSource.removeItem(itemId);

  @override
  Future<void> categoriseItem(String itemId, SavedCategory category) =>
      dataSource.categoriseItem(itemId, category);

  @override
  Future<void> clearCategory(String itemId) => dataSource.clearCategory(itemId);

  @override
  Future<bool> isItemSaved(String lookId) => dataSource.isItemSaved(lookId);
}
