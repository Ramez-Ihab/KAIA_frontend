import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';

abstract class SavedRepository {
  Future<List<SavedItem>> getSavedItems(SavedCategory? filter, SortOrder sortOrder);
  Future<void> saveItem(Look look);
  Future<void> removeItem(String itemId);
  Future<void> categoriseItem(String itemId, SavedCategory category);
  Future<void> clearCategory(String itemId);
  Future<bool> isItemSaved(String lookId);
}