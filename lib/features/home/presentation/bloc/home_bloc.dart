// lib/features/home/presentation/bloc/home_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/home_event.dart';
import 'package:kaia/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<SetActiveTab>(_onSetActiveTab);
    on<ToggleShipsToMe>(_onToggleShipsToMe);
    on<DismissBanner>(_onDismissBanner);
    on<LocationConfirmed>(_onLocationConfirmed);
  }

  void _onSetActiveTab(SetActiveTab event, Emitter<HomeState> emit) {
    emit(state.copyWith(activeTabIndex: event.index));
  }

  void _onToggleShipsToMe(ToggleShipsToMe event, Emitter<HomeState> emit) {
    emit(state.copyWith(shipsToMeEnabled: !state.shipsToMeEnabled));
  }

  void _onDismissBanner(DismissBanner event, Emitter<HomeState> emit) {
    emit(state.copyWith(showBanner: false));
  }

  void _onLocationConfirmed(LocationConfirmed event, Emitter<HomeState> emit) {
    // Setting a location always dismisses the banner and enables ships-to-me
    emit(state.copyWith(showBanner: false, shipsToMeEnabled: true));
  }
}
