// lib/features/location/presentation/bloc/location_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_event.dart';
import 'package:kaia/features/location/presentation/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState.initial()) {
    on<LoadCountries>(_onLoadCountries);
    on<SetLocation>(_onSetLocation);
    on<DismissBanner>(_onDismissBanner);
    on<ToggleShipsToMe>(_onToggleShipsToMe);
  }

  void _onLoadCountries(LoadCountries event, Emitter<LocationState> emit) {
    // Countries already loaded from enum in initial state
    // Later this will call the use case to fetch from API
    emit(state);
  }

  void _onSetLocation(SetLocation event, Emitter<LocationState> emit) {
  emit(state.copyWith(
    selectedCountry: event.country,
    showBanner: false,
    shipsToMeEnabled: true,
  ));
}


  void _onDismissBanner(DismissBanner event, Emitter<LocationState> emit) {
    emit(state.copyWith(showBanner: false));
  }

  void _onToggleShipsToMe(ToggleShipsToMe event, Emitter<LocationState> emit) {
  if (!state.isLocationSet) {
    // Can't enable without a location — UI should open the picker
    return;
  }
  emit(state.copyWith(shipsToMeEnabled: !state.shipsToMeEnabled));
}
}