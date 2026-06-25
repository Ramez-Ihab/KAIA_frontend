// lib/features/home/presentation/bloc/brands_event.dart

import 'package:kaia/core/constants/country.dart';

abstract class BrandsEvent {}

class LoadBrands extends BrandsEvent {}

class FilterByCountry extends BrandsEvent {
  final Country? country;
  FilterByCountry(this.country);
}

class ToggleFavoriteBrandEvent extends BrandsEvent {
  final int index;
  ToggleFavoriteBrandEvent(this.index);
}

class ToggleFavoriteBrandByName extends BrandsEvent {
  final String brandName;
  ToggleFavoriteBrandByName(this.brandName);
}