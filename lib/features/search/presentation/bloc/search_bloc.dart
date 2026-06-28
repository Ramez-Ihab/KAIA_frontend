import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/search/domain/usecases/search_by_text.dart';
import 'package:kaia/features/search/domain/usecases/get_recent_searches.dart';
import 'package:kaia/features/search/domain/usecases/save_recent_search.dart';
import 'package:kaia/features/search/domain/usecases/remove_recent_search.dart';
import 'package:kaia/features/search/domain/usecases/clear_recent_searches.dart';
import 'package:kaia/features/search/presentation/bloc/search_event.dart';
import 'package:kaia/features/search/presentation/bloc/search_state.dart';
import 'package:kaia/core/usecases/usecase.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchByText searchByText;
  final GetRecentSearches getRecentSearches;
  final SaveRecentSearch saveRecentSearch;
  final RemoveRecentSearch removeRecentSearch;
  final ClearRecentSearches clearRecentSearches;

  SearchBloc({
    required this.searchByText,
    required this.getRecentSearches,
    required this.saveRecentSearch,
    required this.removeRecentSearch,
    required this.clearRecentSearches,
  }) : super(SearchState.initial()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ClearSearch>(_onClearSearch);
    on<RemoveRecentSearchEvent>(_onRemoveRecentSearch);
    on<ClearAllRecentSearches>(_onClearAllRecent);
    on<SubmitSearch>(_onSubmitSearch);
  }

  Future<void> _onSearchTextChanged(SearchTextChanged event, Emitter<SearchState> emit) async {
    final query = event.query;

    if (query.isEmpty) {
      emit(state.copyWith(
        searchText: '',
        matchingRecent: [],
        matchingBrands: [],
        hasResults: true,
      ));
      return;
    }

    final matchingRecent = state.recentSearches
        .where((s) => s.toLowerCase().contains(query.toLowerCase()))
        .toList();

    final matchingBrands = await searchByText(query);

    emit(state.copyWith(
      searchText: query,
      matchingRecent: matchingRecent,
      matchingBrands: matchingBrands,
      hasResults: matchingRecent.isNotEmpty || matchingBrands.isNotEmpty,
    ));
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      searchText: '',
      matchingRecent: [],
      matchingBrands: [],
      hasResults: true,
    ));
  }

  Future<void> _onRemoveRecentSearch(RemoveRecentSearchEvent event, Emitter<SearchState> emit) async {
    await removeRecentSearch(event.search);
    final updated = await getRecentSearches(NoParams());

    final matchingRecent = state.isSearching
        ? updated.where((s) => s.toLowerCase().contains(state.searchText.toLowerCase())).toList()
        : <String>[];

    emit(state.copyWith(
      recentSearches: updated,
      matchingRecent: matchingRecent,
    ));
  }

  Future<void> _onClearAllRecent(ClearAllRecentSearches event, Emitter<SearchState> emit) async {
    await clearRecentSearches(NoParams());
    emit(state.copyWith(
      recentSearches: [],
      matchingRecent: [],
    ));
  }

  Future<void> _onSubmitSearch(SubmitSearch event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) return;
    await saveRecentSearch(event.query);
    final updated = await getRecentSearches(NoParams());
    emit(state.copyWith(recentSearches: updated));
  }
}
