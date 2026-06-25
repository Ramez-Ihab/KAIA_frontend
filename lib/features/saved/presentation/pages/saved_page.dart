import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/features/saved/domain/usecases/sort_order.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';
import 'package:kaia/features/saved/presentation/widgets/saved_grid_card.dart';
import 'package:kaia/features/saved/presentation/widgets/saved_list_card.dart';

class SavedPage extends StatelessWidget {
  final VoidCallback onBrowseDiscoverTap;

  const SavedPage({super.key, required this.onBrowseDiscoverTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedBloc, SavedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Image.asset('assets/images/KAIA.png', width: 200, height: 48, alignment: Alignment.topLeft),
            ),
            const SizedBox(height: 10),

            // Title row
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saved',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GlacialIndifference',
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showSortBottomSheet(context, state.sortOrder),
                        child: Row(
                          children: [
                            Icon(Icons.swap_vert, size: 18, color: darkgreyColor),
                            const SizedBox(width: 4),
                            Text(
                              state.sortOrder.label,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'GlacialIndifference',
                                color: darkgreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          if (!state.isGridView) {
                            context.read<SavedBloc>().add(ToggleViewMode());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: state.isGridView ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.grid_view,
                            size: 18,
                            color: state.isGridView ? Colors.white : darkgreyColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          if (state.isGridView) {
                            context.read<SavedBloc>().add(ToggleViewMode());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: !state.isGridView ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.view_list,
                            size: 18,
                            color: !state.isGridView ? Colors.white : darkgreyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Category chips
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
                itemCount: SavedCategory.values.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    final isSelected = state.selectedCategory == null;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: const Text('All'),
                        selected: isSelected,
                        onSelected: (_) => context.read<SavedBloc>().add(ChangeCategoryFilter(null)),
                        selectedColor: primaryColor,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          fontFamily: 'GlacialIndifference',
                          fontSize: 13,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        shape: const StadiumBorder(),
                        side: BorderSide(color: isSelected ? primaryColor : darkgreyColor.withValues(alpha:0.3)),
                        showCheckmark: false,
                      ),
                    );
                  }
                  final cat = SavedCategory.values[index - 1];
                  final isSelected = state.selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat.label),
                      selected: isSelected,
                      onSelected: (_) => context.read<SavedBloc>().add(ChangeCategoryFilter(cat)),
                      selectedColor: primaryColor,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        fontFamily: 'GlacialIndifference',
                        fontSize: 13,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      shape: const StadiumBorder(),
                      side: BorderSide(color: isSelected ? primaryColor : darkgreyColor.withValues(alpha:0.3)),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),

            // Item count
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
              child: Text(
                '${state.filteredItems.length} items',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'GlacialIndifference',
                  color: const Color.fromARGB(255, 122, 128, 139),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Content
            Expanded(
              child: state.filteredItems.isEmpty
                  ? _buildEmptyState(context, state)
                  : state.isGridView
                      ? _buildGridView(context, state)
                      : _buildListView(context, state),
            ),
          ],
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context, SortOrder currentSort) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, MediaQuery.of(sheetContext).padding.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: darkgreyColor.withValues(alpha:0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sort by',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'GlacialIndifference',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(sheetContext),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...SortOrder.values.map((sort) {
                  final isSelected = currentSort == sort;
                  return GestureDetector(
                    onTap: () {
                      context.read<SavedBloc>().add(ChangeSortOrder(sort));
                      Navigator.pop(sheetContext);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sort.label,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'GlacialIndifference',
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          if (isSelected)
                            const Icon(Icons.check, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCategoryBottomSheet(BuildContext context, SavedItem item, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, MediaQuery.of(sheetContext).padding.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: darkgreyColor.withValues(alpha:0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'GlacialIndifference',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(sheetContext),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...SavedCategory.values.map((cat) {
                          final isSelected = item.category == cat;
                          return GestureDetector(
                            onTap: () {
                              context.read<SavedBloc>().add(
                                CategoriseItem(index: index, category: cat),
                              );
                              Navigator.pop(sheetContext);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cat.label,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'GlacialIndifference',
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  if (isSelected)
                                    const Icon(Icons.check, color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    context.read<SavedBloc>().add(ClearItemCategoryEvent(index));
                    Navigator.pop(sheetContext);
                  },
                  child: Text(
                    'Clear category',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'GlacialIndifference',
                      color: darkgreyColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, SavedState state) {
    final categoryName = state.selectedCategory?.label;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 50, color: darkgreyColor.withValues(alpha:0.3)),
            const SizedBox(height: 16),
            Text(
              categoryName != null
                  ? 'Nothing in "$categoryName" yet'
                  : 'Nothing saved yet',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'GlacialIndifference',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              categoryName != null
                  ? 'Tag your saved items with a category to see them here.'
                  : 'Browse For You and Discover, then tap the bookmark icon to save looks here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GlacialIndifference',
                color: darkgreyColor,
              ),
            ),
            if (categoryName == null) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onBrowseDiscoverTap,
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Browse Discover',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GlacialIndifference',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, SavedState state) {
    final items = state.filteredItems;
    final leftItems = <int>[];
    final rightItems = <int>[];

    for (int i = 0; i < items.length; i++) {
      if (i % 2 == 0) {
        leftItems.add(i);
      } else {
        rightItems.add(i);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(7.0, 0, 7.0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: leftItems.asMap().entries.map((entry) {
                final itemIndex = entry.value;
                final isOddPosition = entry.key % 2 != 0;
                return Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 10),
                  child: SizedBox(
                    height: isOddPosition ? 180 : 240,
                    child: SavedGridCard(
                      item: items[itemIndex],
                      onCategoryTap: () => _showCategoryBottomSheet(context, items[itemIndex], itemIndex),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: Column(
                children: rightItems.asMap().entries.map((entry) {
                  final itemIndex = entry.value;
                  final isOddPosition = entry.key % 2 != 0;
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 10),
                    child: SizedBox(
                      height: isOddPosition ? 240 : 180,
                      child: SavedGridCard(
                        item: items[itemIndex],
                        onCategoryTap: () => _showCategoryBottomSheet(context, items[itemIndex], itemIndex),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, SavedState state) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0, 7.0, 0),
      itemCount: state.filteredItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return SavedListCard(
          item: state.filteredItems[index],
          onCategoryTap: () => _showCategoryBottomSheet(context, state.filteredItems[index], index),
          onExternalTap: () {
            // Open external URL later
          },
        );
      },
    );
  }
}