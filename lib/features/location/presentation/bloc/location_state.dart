// lib/features/location/presentation/bloc/location_state.dart

import 'package:kaia/core/constants/country.dart';

class LocationState {
  final Country? selectedCountry;
  final List<Country> countries;

  const LocationState({
    required this.selectedCountry,
    required this.countries,
  });

  factory LocationState.initial() {
    return LocationState(
      selectedCountry: null,
      countries: Country.values.where((c) => c != Country.all).toList(),
    );
  }

  LocationState copyWith({
    Country? selectedCountry,
    bool clearCountry = false,
    List<Country>? countries,
  }) {
    return LocationState(
      selectedCountry: clearCountry ? null : (selectedCountry ?? this.selectedCountry),
      countries: countries ?? this.countries,
    );
  }

  bool get isLocationSet => selectedCountry != null;
}
