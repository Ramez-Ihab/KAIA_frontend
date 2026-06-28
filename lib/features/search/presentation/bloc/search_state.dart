// lib/features/search/presentation/bloc/search_state.dart

import 'package:kaia/core/entities/brand.dart';

class SearchState {
  final String searchText;
  final List<String> recentSearches;
  final List<String> matchingRecent;
  final List<Brand> matchingBrands;
  final bool hasResults;

  SearchState({
    required this.searchText,
    required this.recentSearches,
    required this.matchingRecent,
    required this.matchingBrands,
    required this.hasResults,
  });

  factory SearchState.initial() {
    return SearchState(
      searchText: '',
      recentSearches: [
        'Spring florals',
        'Minimalist',
        'Night out',
        'Cairo inspo',
        'Boho',
      ],
      matchingRecent: [],
      matchingBrands: [],
      hasResults: true,
    );
  }

  SearchState copyWith({
    String? searchText,
    List<String>? recentSearches,
    List<String>? matchingRecent,
    List<Brand>? matchingBrands,
    bool? hasResults,
  }) {
    return SearchState(
      searchText: searchText ?? this.searchText,
      recentSearches: recentSearches ?? this.recentSearches,
      matchingRecent: matchingRecent ?? this.matchingRecent,
      matchingBrands: matchingBrands ?? this.matchingBrands,
      hasResults: hasResults ?? this.hasResults,
    );
  }

  bool get isSearching => searchText.isNotEmpty;
  bool get hasRecentSearches => recentSearches.isNotEmpty;
}