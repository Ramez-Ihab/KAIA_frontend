enum SortOrder {
  recentlySaved('Recently saved'),
  byBrand('By brand'),
  byCategory('By category');

  final String label;
  const SortOrder(this.label);
}