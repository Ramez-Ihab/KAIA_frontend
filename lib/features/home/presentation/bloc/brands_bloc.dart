// lib/features/home/presentation/bloc/brands_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/features/home/presentation/bloc/brands_event.dart';
import 'package:kaia/features/home/presentation/bloc/brands_state.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  BrandsBloc() : super(BrandsState.initial()) {
    on<LoadBrands>(_onLoadBrands);
    on<FilterByCountry>(_onFilterByCountry);
    on<ToggleFavoriteBrandEvent>(_onToggleFavorite);
    on<ToggleFavoriteBrandByName>(_onToggleFavoriteByName);
  }

  void _onLoadBrands(LoadBrands event, Emitter<BrandsState> emit) {
    // Hardcoded for now — later replaced by use case
    final brands = [
      Brand(
        name: '1309 Studios',
        initials: '1S',
        country: Country.qatar,
        categories: [BrandCategory.womenswear],
        websiteUrl: 'https://example.com',
        shipsTo: [Country.qatar],
        isFavorited: false,
      ),
      Brand(
        name: 'Nada Debs',
        initials: 'ND',
        country: Country.lebanon,
        categories: [BrandCategory.homeAccessories],
        websiteUrl: 'https://example.com',
        shipsTo: [Country.lebanon],
        isFavorited: false,
      ),
      Brand(
        name: 'Okhtein',
        initials: 'OK',
        country: Country.egypt,
        categories: [BrandCategory.bags, BrandCategory.jewellery],
        websiteUrl: 'https://example.com',
        shipsTo: [Country.egypt],
        isFavorited: true,
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
      Brand(
        name: "L'Afshar",
        initials: 'LA',
        country: Country.egypt,
        categories: [BrandCategory.bags],
        websiteUrl: 'https://example.com',
        shipsTo: [Country.egypt],
        isFavorited: false,
      ),
      Brand(
        name: 'Emergency Room Beirut',
        initials: 'ER',
        country: Country.lebanon,
        categories: [BrandCategory.womenswear],
        websiteUrl: 'https://example.com',
        shipsTo: [Country.lebanon],
        isFavorited: false,
      ),
      Brand(
        name: 'Irth Jewels',
        initials: 'IJ',
        country: Country.uae,
        categories: [BrandCategory.jewellery],
        websiteUrl: 'https://example.com',
        shipsTo: [Country.uae],
        isFavorited: false,
      ),
    ];

    emit(state.copyWith(
      allBrands: brands,
      filteredBrands: brands,
    ));
  }

  void _onFilterByCountry(FilterByCountry event, Emitter<BrandsState> emit) {
    final filtered = _filterBrands(state.allBrands, event.country);
    emit(state.copyWith(
      selectedCountry: event.country,
      clearCountry: event.country == null,
      filteredBrands: filtered,
    ));
  }

  void _onToggleFavorite(ToggleFavoriteBrandEvent event, Emitter<BrandsState> emit) {
    final updatedAll = List<Brand>.from(state.allBrands);
    final brand = updatedAll[event.index];
    updatedAll[event.index] = Brand(
      name: brand.name,
      initials: brand.initials,
      country: brand.country,
      categories: brand.categories,
      websiteUrl: brand.websiteUrl,
      shipsTo: brand.shipsTo,
      isFavorited: !brand.isFavorited,
    );

    emit(state.copyWith(
      allBrands: updatedAll,
      filteredBrands: _filterBrands(updatedAll, state.selectedCountry),
    ));
  }

  List<Brand> _filterBrands(List<Brand> brands, Country? country) {
    if (country == null) return List.from(brands);
    return brands.where((b) => b.country == country).toList();
  }

  bool isBrandFavorited(String brandName) {
  return state.allBrands.any((b) => b.name == brandName && b.isFavorited);
}

  void _onToggleFavoriteByName(ToggleFavoriteBrandByName event, Emitter<BrandsState> emit) {
  final updatedAll = List<Brand>.from(state.allBrands);
  final index = updatedAll.indexWhere((b) => b.name == event.brandName);
  if (index == -1) return;

  final brand = updatedAll[index];
  updatedAll[index] = Brand(
    name: brand.name,
    initials: brand.initials,
    country: brand.country,
    categories: brand.categories,
    websiteUrl: brand.websiteUrl,
    shipsTo: brand.shipsTo,
    isFavorited: !brand.isFavorited,
  );

  emit(state.copyWith(
    allBrands: updatedAll,
    filteredBrands: _filterBrands(updatedAll, state.selectedCountry),
  ));
}
}