import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/categorise_saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/clear_item_category.dart';
import 'package:kaia/features/saved/domain/usecases/get_saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/is_item_saved.dart';
import 'package:kaia/features/saved/domain/usecases/remove_saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/domain/usecases/toggle_save_item.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final GetSavedItems getSavedItems;
  final ToggleSaveItem toggleSaveItem;
  final RemoveSavedItem removeSavedItem;
  final CategoriseSavedItem categoriseSavedItem;
  final ClearItemCategory clearItemCategory;
  final IsItemSaved isItemSaved;

  SavedBloc({
    required this.getSavedItems,
    required this.toggleSaveItem,
    required this.removeSavedItem,
    required this.categoriseSavedItem,
    required this.clearItemCategory,
    required this.isItemSaved,
  }) : super(SavedState.initial()) {
    on<LoadSavedItems>(_onLoadSavedItems);
    on<ToggleSaveItemEvent>(_onToggleSaveItem);
    on<RemoveSavedItemEvent>(_onRemoveSavedItem);
    on<ChangeCategoryFilter>(_onChangeCategoryFilter);
    on<ChangeSortOrder>(_onChangeSortOrder);
    on<ToggleViewMode>(_onToggleViewMode);
    on<CategoriseItem>(_onCategoriseItem);
    on<ClearItemCategoryEvent>(_onClearItemCategory);
  }

  Future<void> _onLoadSavedItems(LoadSavedItems event, Emitter<SavedState> emit) async {
    final items = await getSavedItems(GetSavedItemsParams(
      filter: state.selectedCategory,
      sortOrder: state.sortOrder,
    ));
    emit(state.copyWith(
      allItems: items,
      filteredItems: _filterItems(items, state.selectedCategory),
    ));
  }

  Future<void> _onToggleSaveItem(ToggleSaveItemEvent event, Emitter<SavedState> emit) async {
    final id = '${event.look.styleTag}|${event.look.brand.name}';
    final saved = await isItemSaved(id);

    if (saved) {
      await removeSavedItem(id);
      final updatedItems = state.allItems.where((i) =>
          '${i.look.styleTag}|${i.look.brand.name}' != id).toList();
      emit(state.copyWith(
        allItems: updatedItems,
        filteredItems: _filterItems(updatedItems, state.selectedCategory),
      ));
    } else {
      await toggleSaveItem(event.look);
      final newItem = SavedItem(look: event.look, savedDate: DateTime.now());
      final updatedItems = [...state.allItems, newItem];
      emit(state.copyWith(
        allItems: updatedItems,
        filteredItems: _filterItems(updatedItems, state.selectedCategory),
      ));
    }
  }

  Future<void> _onRemoveSavedItem(RemoveSavedItemEvent event, Emitter<SavedState> emit) async {
    final item = state.filteredItems[event.index];
    final id = '${item.look.styleTag}|${item.look.brand.name}';
    await removeSavedItem(id);
    final updatedItems = state.allItems.where((i) =>
        '${i.look.styleTag}|${i.look.brand.name}' != id).toList();
    emit(state.copyWith(
      allItems: updatedItems,
      filteredItems: _filterItems(updatedItems, state.selectedCategory),
    ));
  }

  void _onChangeCategoryFilter(ChangeCategoryFilter event, Emitter<SavedState> emit) {
    emit(state.copyWith(
      selectedCategory: event.category,
      clearCategory: event.category == null,
      filteredItems: _filterItems(state.allItems, event.category),
    ));
  }

  void _onChangeSortOrder(ChangeSortOrder event, Emitter<SavedState> emit) {
    final sorted = _sortItems(state.filteredItems, event.sortOrder);
    emit(state.copyWith(
      sortOrder: event.sortOrder,
      filteredItems: sorted,
    ));
  }

  void _onToggleViewMode(ToggleViewMode event, Emitter<SavedState> emit) {
    emit(state.copyWith(isGridView: !state.isGridView));
  }

  Future<void> _onCategoriseItem(CategoriseItem event, Emitter<SavedState> emit) async {
    final item = state.allItems[event.index];
    final id = '${item.look.styleTag}|${item.look.brand.name}';
    await categoriseSavedItem(CategoriseSavedItemParams(itemId: id, category: event.category));
    final updatedItems = List<SavedItem>.from(state.allItems);
    updatedItems[event.index] = item.copyWith(category: event.category);
    emit(state.copyWith(
      allItems: updatedItems,
      filteredItems: _filterItems(updatedItems, state.selectedCategory),
    ));
  }

  Future<void> _onClearItemCategory(ClearItemCategoryEvent event, Emitter<SavedState> emit) async {
    final item = state.allItems[event.index];
    final id = '${item.look.styleTag}|${item.look.brand.name}';
    await clearItemCategory(id);
    final updatedItems = List<SavedItem>.from(state.allItems);
    updatedItems[event.index] = SavedItem(look: item.look, savedDate: item.savedDate);
    emit(state.copyWith(
      allItems: updatedItems,
      filteredItems: _filterItems(updatedItems, state.selectedCategory),
    ));
  }

  bool isLookSaved(Look look) {
    return state.allItems.any(
      (item) => item.look.styleTag == look.styleTag &&
                item.look.brand.name == look.brand.name,
    );
  }

  List<SavedItem> _filterItems(List<SavedItem> items, SavedCategory? category) {
    if (category == null) return List.from(items);
    return items.where((item) => item.category == category).toList();
  }

  List<SavedItem> _sortItems(List<SavedItem> items, SortOrder order) {
    final sorted = List<SavedItem>.from(items);
    switch (order) {
      case SortOrder.recentlySaved:
        sorted.sort((a, b) => b.savedDate.compareTo(a.savedDate));
        break;
      case SortOrder.byBrand:
        sorted.sort((a, b) => a.look.brand.name.compareTo(b.look.brand.name));
        break;
      case SortOrder.byCategory:
        sorted.sort((a, b) => (a.category?.label ?? 'ZZZ').compareTo(b.category?.label ?? 'ZZZ'));
        break;
    }
    return sorted;
  }
}
