// lib/features/profile/presentation/bloc/preferences_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/preferences_event.dart';
import 'package:kaia/features/profile/presentation/bloc/preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc() : super(PreferencesState.initial()) {
    on<LoadPreferences>(_onLoadPreferences);
    on<ToggleContentPreference>(_onToggleContentPreference);
    on<ToggleSize>(_onToggleSize);
    on<ToggleShoeSize>(_onToggleShoeSize);
  }

  void _onLoadPreferences(LoadPreferences event, Emitter<PreferencesState> emit) {
    emit(state.copyWith(
      contentPreferences: Set.from(event.current.contentPreferences),
      sizes: Set.from(event.current.sizes),
      shoeSizes: Set.from(event.current.shoeSizes),
    ));
  }

  void _onToggleContentPreference(ToggleContentPreference event, Emitter<PreferencesState> emit) {
    final updated = Set<String>.from(state.contentPreferences);
    if (updated.contains(event.preference)) {
      updated.remove(event.preference);
    } else {
      updated.add(event.preference);
    }
    emit(state.copyWith(contentPreferences: updated));
  }

  void _onToggleSize(ToggleSize event, Emitter<PreferencesState> emit) {
    final updated = Set<String>.from(state.sizes);
    if (updated.contains(event.size)) {
      updated.remove(event.size);
    } else {
      updated.add(event.size);
    }
    emit(state.copyWith(sizes: updated));
  }

  void _onToggleShoeSize(ToggleShoeSize event, Emitter<PreferencesState> emit) {
    final updated = Set<String>.from(state.shoeSizes);
    if (updated.contains(event.shoeSize)) {
      updated.remove(event.shoeSize);
    } else {
      updated.add(event.shoeSize);
    }
    emit(state.copyWith(shoeSizes: updated));
  }
}
