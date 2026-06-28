import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/location/domain/usecases/get_countries.dart';
import 'package:kaia/features/location/domain/usecases/set_user_location.dart';
import 'package:kaia/features/location/domain/usecases/get_user_location.dart';
import 'package:kaia/features/location/presentation/bloc/location_event.dart';
import 'package:kaia/features/location/presentation/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCountries getCountries;
  final SetUserLocation setUserLocation;
  final GetUserLocation getUserLocation;

  LocationBloc({
    required this.getCountries,
    required this.setUserLocation,
    required this.getUserLocation,
  }) : super(LocationState.initial()) {
    on<LoadCountries>(_onLoadCountries);
    on<SetLocation>(_onSetLocation);
  }

  Future<void> _onLoadCountries(LoadCountries event, Emitter<LocationState> emit) async {
    final countries = await getCountries(NoParams());
    final saved = await getUserLocation(NoParams());
    emit(state.copyWith(
      countries: countries,
      selectedCountry: saved,
      clearCountry: saved == null,
    ));
  }

  Future<void> _onSetLocation(SetLocation event, Emitter<LocationState> emit) async {
    await setUserLocation(event.country);
    emit(state.copyWith(selectedCountry: event.country));
  }
}
