// lib/features/profile/presentation/bloc/preferences_event.dart

import 'package:kaia/features/profile/domain/entities/user_preferences.dart';

abstract class PreferencesEvent {}

// Called when the sheet opens — seeds draft from the currently saved ProfileBloc state
class LoadPreferences extends PreferencesEvent {
  final UserPreferences current;
  LoadPreferences(this.current);
}

class ToggleContentPreference extends PreferencesEvent {
  final String preference;
  ToggleContentPreference(this.preference);
}

class ToggleSize extends PreferencesEvent {
  final String size;
  ToggleSize(this.size);
}

class ToggleShoeSize extends PreferencesEvent {
  final String shoeSize;
  ToggleShoeSize(this.shoeSize);
}
