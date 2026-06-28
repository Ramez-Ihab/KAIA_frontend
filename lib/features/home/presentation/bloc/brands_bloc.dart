import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/features/home/domain/usecases/get_brands_list.dart';
import 'package:kaia/features/home/domain/usecases/toggle_favorite_brand.dart';
import 'package:kaia/features/home/presentation/bloc/brands_event.dart';
import 'package:kaia/features/home/presentation/bloc/brands_state.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  final GetBrandsList getBrandsList;
  final ToggleFavoriteBrand toggleFavoriteBrand;

  BrandsBloc({
    required this.getBrandsList,
    required this.toggleFavoriteBrand,
  }) : super(BrandsState.initial()) {
    on<LoadBrands>(_onLoadBrands);
    on<FilterByCountry>(_onFilterByCountry);
    on<ToggleFavoriteBrandEvent>(_onToggleFavorite);
    on<ToggleFavoriteBrandByName>(_onToggleFavoriteByName);
  }

  Future<void> _onLoadBrands(LoadBrands event, Emitter<BrandsState> emit) async {
    final brands = await getBrandsList(state.selectedCountry);
    emit(state.copyWith(
      allBrands: brands,
      filteredBrands: brands,
    ));
  }

  Future<void> _onFilterByCountry(FilterByCountry event, Emitter<BrandsState> emit) async {
    final brands = await getBrandsList(event.country);
    emit(state.copyWith(
      selectedCountry: event.country,
      clearCountry: event.country == null,
      filteredBrands: brands,
      allBrands: event.country == null ? brands : state.allBrands,
    ));
  }

  Future<void> _onToggleFavorite(ToggleFavoriteBrandEvent event, Emitter<BrandsState> emit) async {
    final brand = state.allBrands[event.index];
    await toggleFavoriteBrand(brand.name);
    final updated = await getBrandsList(null);
    emit(state.copyWith(
      allBrands: updated,
      filteredBrands: _filterBrands(updated, state.selectedCountry),
    ));
  }

  Future<void> _onToggleFavoriteByName(ToggleFavoriteBrandByName event, Emitter<BrandsState> emit) async {
    await toggleFavoriteBrand(event.brandName);
    final updated = await getBrandsList(null);
    emit(state.copyWith(
      allBrands: updated,
      filteredBrands: _filterBrands(updated, state.selectedCountry),
    ));
  }

  List<Brand> _filterBrands(List<Brand> brands, Country? country) {
    if (country == null) return List.from(brands);
    return brands.where((b) => b.country == country).toList();
  }

  bool isBrandFavorited(String brandName) {
    return state.allBrands.any((b) => b.name == brandName && b.isFavorited);
  }
}
