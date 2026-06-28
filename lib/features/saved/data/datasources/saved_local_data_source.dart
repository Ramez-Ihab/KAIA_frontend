import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';

abstract class SavedLocalDataSource {
  Future<List<SavedItem>> getSavedItems(SavedCategory? filter, SortOrder sortOrder);
  Future<void> saveItem(Look look);
  Future<void> removeItem(String itemId);
  Future<void> categoriseItem(String itemId, SavedCategory category);
  Future<void> clearCategory(String itemId);
  Future<bool> isItemSaved(String itemId);
}

class FakeSavedLocalDataSource implements SavedLocalDataSource {
  final List<SavedItem> _items = [];

  // itemId = "styleTag|brandName"
  static String _id(SavedItem item) => '${item.look.styleTag}|${item.look.brand.name}';
  static String _lookId(Look look) => '${look.styleTag}|${look.brand.name}';

  @override
  Future<List<SavedItem>> getSavedItems(SavedCategory? filter, SortOrder sortOrder) async {
    var result = filter == null
        ? List<SavedItem>.from(_items)
        : _items.where((i) => i.category == filter).toList();
    switch (sortOrder) {
      case SortOrder.recentlySaved:
        result.sort((a, b) => b.savedDate.compareTo(a.savedDate));
        break;
      case SortOrder.byBrand:
        result.sort((a, b) => a.look.brand.name.compareTo(b.look.brand.name));
        break;
      case SortOrder.byCategory:
        result.sort((a, b) => (a.category?.label ?? 'ZZZ').compareTo(b.category?.label ?? 'ZZZ'));
        break;
    }
    return result;
  }

  @override
  Future<void> saveItem(Look look) async {
    if (!_items.any((i) => _id(i) == _lookId(look))) {
      _items.add(SavedItem(look: look, savedDate: DateTime.now()));
    }
  }

  @override
  Future<void> removeItem(String itemId) async {
    _items.removeWhere((i) => _id(i) == itemId);
  }

  @override
  Future<void> categoriseItem(String itemId, SavedCategory category) async {
    final index = _items.indexWhere((i) => _id(i) == itemId);
    if (index != -1) _items[index] = _items[index].copyWith(category: category);
  }

  @override
  Future<void> clearCategory(String itemId) async {
    final index = _items.indexWhere((i) => _id(i) == itemId);
    if (index != -1) {
      _items[index] = SavedItem(look: _items[index].look, savedDate: _items[index].savedDate);
    }
  }

  @override
  Future<bool> isItemSaved(String itemId) async {
    return _items.any((i) => _id(i) == itemId);
  }
}
