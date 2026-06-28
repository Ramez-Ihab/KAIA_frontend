// lib/features/location/presentation/bloc/location_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_event.dart';
import 'package:kaia/features/location/presentation/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState.initial()) {
    on<LoadCountries>(_onLoadCountries);
    on<SetLocation>(_onSetLocation);
  }

  void _onLoadCountries(LoadCountries event, Emitter<LocationState> emit) {
    // Countries already loaded from enum in initial state
    // Later this will call the use case to fetch from API
    emit(state);
  }

  void _onSetLocation(SetLocation event, Emitter<LocationState> emit) {
    emit(state.copyWith(selectedCountry: event.country));
  }
}
