// lib/features/saved/presentation/bloc/saved_event.dart

import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';

abstract class SavedEvent {}

class LoadSavedItems extends SavedEvent {}

class ToggleSaveItemEvent extends SavedEvent {
  final Look look;
  ToggleSaveItemEvent(this.look);
}

class RemoveSavedItemEvent extends SavedEvent {
  final int index;
  RemoveSavedItemEvent(this.index);
}

class ChangeCategoryFilter extends SavedEvent {
  final SavedCategory? category;
  ChangeCategoryFilter(this.category);
}

class ChangeSortOrder extends SavedEvent {
  final SortOrder sortOrder;
  ChangeSortOrder(this.sortOrder);
}

class ToggleViewMode extends SavedEvent {}

class CategoriseItem extends SavedEvent {
  final int index;
  final SavedCategory category;
  CategoriseItem({required this.index, required this.category});
}

class ClearItemCategoryEvent extends SavedEvent {
  final int index;
  ClearItemCategoryEvent(this.index);
}