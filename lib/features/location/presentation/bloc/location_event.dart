// lib/features/location/presentation/bloc/location_event.dart

import 'package:kaia/core/constants/country.dart';

abstract class LocationEvent {}

class LoadCountries extends LocationEvent {}

class SetLocation extends LocationEvent {
  final Country country;
  SetLocation(this.country);
}
