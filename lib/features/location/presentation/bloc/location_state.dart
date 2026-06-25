// lib/features/location/presentation/bloc/location_state.dart

import 'package:kaia/core/constants/country.dart';
class LocationState {
  final Country? selectedCountry;
  final List<Country> countries;
  final bool showBanner;
  final bool shipsToMeEnabled;

  LocationState({
    required this.selectedCountry,
    required this.countries,
    required this.showBanner,
    required this.shipsToMeEnabled,
  });

  factory LocationState.initial() {
    return LocationState(
      selectedCountry: null,
      countries: Country.values.where((c) => c != Country.all).toList(),
      showBanner: true,
      shipsToMeEnabled: false,
    );
  }

  LocationState copyWith({
    Country? selectedCountry,
    bool clearCountry = false,
    List<Country>? countries,
    bool? showBanner,
    bool? shipsToMeEnabled,
  }) {
    return LocationState(
      selectedCountry: clearCountry ? null : (selectedCountry ?? this.selectedCountry),
      countries: countries ?? this.countries,
      showBanner: showBanner ?? this.showBanner,
      shipsToMeEnabled: shipsToMeEnabled ?? this.shipsToMeEnabled,
    );
  }

  bool get isLocationSet => selectedCountry != null;
} 