// lib/features/saved/presentation/bloc/saved_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(SavedState.initial()) {
    on<LoadSavedItems>(_onLoadSavedItems);
    on<ToggleSaveItemEvent>(_onToggleSaveItem);
    on<RemoveSavedItemEvent>(_onRemoveSavedItem);
    on<ChangeCategoryFilter>(_onChangeCategoryFilter);
    on<ChangeSortOrder>(_onChangeSortOrder);
    on<ToggleViewMode>(_onToggleViewMode);
    on<CategoriseItem>(_onCategoriseItem);
    on<ClearItemCategoryEvent>(_onClearItemCategory);
  }

  void _onLoadSavedItems(LoadSavedItems event, Emitter<SavedState> emit) {
    // Later this will call the use case
    // For now emit current state
    emit(state.copyWith(
      filteredItems: _filterItems(state.allItems, state.selectedCategory),
    ));
  }

  void _onToggleSaveItem(ToggleSaveItemEvent event, Emitter<SavedState> emit) {
    final existingIndex = state.allItems.indexWhere(
      (item) => item.look.styleTag == event.look.styleTag && 
                item.look.brand.name == event.look.brand.name,
    );

    List<SavedItem> updatedItems;

    if (existingIndex != -1) {
      // Already saved — remove it
      updatedItems = List.from(state.allItems)..removeAt(existingIndex);
    } else {
      // Not saved — add it
      updatedItems = List.from(state.allItems)
        ..add(SavedItem(
          look: event.look,
          savedDate: DateTime.now(),
        ));
    }

    emit(state.copyWith(
      allItems: updatedItems,
      filteredItems: _filterItems(updatedItems, state.selectedCategory),
    ));
  }

  void _onRemoveSavedItem(RemoveSavedItemEvent event, Emitter<SavedState> emit) {
    final updatedItems = List<SavedItem>.from(state.allItems)..removeAt(event.index);
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

  void _onCategoriseItem(CategoriseItem event, Emitter<SavedState> emit) {
    final updatedItems = List<SavedItem>.from(state.allItems);
    final item = updatedItems[event.index];
    updatedItems[event.index] = item.copyWith(category: event.category);

    emit(state.copyWith(
      allItems: updatedItems,
      filteredItems: _filterItems(updatedItems, state.selectedCategory),
    ));
  }

  void _onClearItemCategory(ClearItemCategoryEvent event, Emitter<SavedState> emit) {
    final updatedItems = List<SavedItem>.from(state.allItems);
    final item = updatedItems[event.index];
    updatedItems[event.index] = SavedItem(
      look: item.look,
      savedDate: item.savedDate,
    );

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