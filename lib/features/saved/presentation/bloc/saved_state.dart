// lib/features/saved/presentation/bloc/saved_state.dart

import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';

class SavedState {
  final List<SavedItem> allItems;
  final List<SavedItem> filteredItems;
  final SavedCategory? selectedCategory;
  final SortOrder sortOrder;
  final bool isGridView;

  SavedState({
    required this.allItems,
    required this.filteredItems,
    required this.selectedCategory,
    required this.sortOrder,
    required this.isGridView,
  });

  factory SavedState.initial() {
    return SavedState(
      allItems: [],
      filteredItems: [],
      selectedCategory: null,
      sortOrder: SortOrder.recentlySaved,
      isGridView: true,
    );
  }

  SavedState copyWith({
    List<SavedItem>? allItems,
    List<SavedItem>? filteredItems,
    SavedCategory? selectedCategory,
    bool clearCategory = false,
    SortOrder? sortOrder,
    bool? isGridView,
  }) {
    return SavedState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      selectedCategory: clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      sortOrder: sortOrder ?? this.sortOrder,
      isGridView: isGridView ?? this.isGridView,
    );
  }
}