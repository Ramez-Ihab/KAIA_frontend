// lib/features/home/presentation/bloc/brands_state.dart

import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/constants/country.dart';

class BrandsState {
  final List<Brand> allBrands;
  final List<Brand> filteredBrands;
  final Country? selectedCountry;

  BrandsState({
    required this.allBrands,
    required this.filteredBrands,
    required this.selectedCountry,
  });

  factory BrandsState.initial() {
    return BrandsState(
      allBrands: [],
      filteredBrands: [],
      selectedCountry: null,
    );
  }

  BrandsState copyWith({
    List<Brand>? allBrands,
    List<Brand>? filteredBrands,
    Country? selectedCountry,
    bool clearCountry = false,
  }) {
    return BrandsState(
      allBrands: allBrands ?? this.allBrands,
      filteredBrands: filteredBrands ?? this.filteredBrands,
      selectedCountry: clearCountry ? null : (selectedCountry ?? this.selectedCountry),
    );
  }
}