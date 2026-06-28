// lib/features/search/presentation/bloc/search_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/features/search/presentation/bloc/search_event.dart';
import 'package:kaia/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ClearSearch>(_onClearSearch);
    on<RemoveRecentSearchEvent>(_onRemoveRecentSearch);
    on<ClearAllRecentSearches>(_onClearAllRecent);
    on<SubmitSearch>(_onSubmitSearch);
  }

  // Hardcoded for now — later replaced by use case
  final List<Brand> _searchableBrands = [
    Brand(
      name: '6901 Cairo',
      initials: '6C',
      country: Country.egypt,
      categories: [BrandCategory.womenswear, BrandCategory.menswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    ),
    Brand(
      name: 'Anut Cairo',
      initials: 'AC',
      country: Country.egypt,
      categories: [BrandCategory.homeAccessories],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    ),
    Brand(
      name: 'Rebel Cairo',
      initials: 'RC',
      country: Country.egypt,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    ),
    Brand(
      name: 'Okhtein',
      initials: 'OK',
      country: Country.egypt,
      categories: [BrandCategory.bags, BrandCategory.jewellery],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    ),
    Brand(
      name: 'Reemami',
      initials: 'RE',
      country: Country.egypt,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    ),
  ];

  void _onSearchTextChanged(SearchTextChanged event, Emitter<SearchState> emit) {
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

    final matchingBrands = _searchableBrands
        .where((b) => b.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

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

  void _onRemoveRecentSearch(RemoveRecentSearchEvent event, Emitter<SearchState> emit) {
    final updated = List<String>.from(state.recentSearches)..remove(event.search);
    
    // Recompute matching if currently searching
    final matchingRecent = state.isSearching
        ? updated.where((s) => s.toLowerCase().contains(state.searchText.toLowerCase())).toList()
        : <String>[];

    emit(state.copyWith(
      recentSearches: updated,
      matchingRecent: matchingRecent,
    ));
  }

  void _onClearAllRecent(ClearAllRecentSearches event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      recentSearches: [],
      matchingRecent: [],
    ));
  }

  void _onSubmitSearch(SubmitSearch event, Emitter<SearchState> emit) {
    if (event.query.isEmpty) return;

    final updated = List<String>.from(state.recentSearches);
    if (!updated.contains(event.query)) {
      updated.insert(0, event.query);
    }

    emit(state.copyWith(recentSearches: updated));
  }
}