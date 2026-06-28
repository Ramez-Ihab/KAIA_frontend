// lib/features/search/presentation/bloc/search_event.dart

abstract class SearchEvent {}

class SearchTextChanged extends SearchEvent {
  final String query;
  SearchTextChanged(this.query);
}

class ClearSearch extends SearchEvent {}

class RemoveRecentSearchEvent extends SearchEvent {
  final String search;
  RemoveRecentSearchEvent(this.search);
}

class ClearAllRecentSearches extends SearchEvent {}

class SubmitSearch extends SearchEvent {
  final String query;
  SubmitSearch(this.query);
}