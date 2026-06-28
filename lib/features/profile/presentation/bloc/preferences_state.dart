// lib/features/profile/presentation/bloc/preferences_state.dart

class PreferencesState {
  final Set<String> contentPreferences;
  final Set<String> sizes;
  final Set<String> shoeSizes;

  const PreferencesState({
    required this.contentPreferences,
    required this.sizes,
    required this.shoeSizes,
  });

  factory PreferencesState.initial() => const PreferencesState(
        contentPreferences: {},
        sizes: {},
        shoeSizes: {},
      );

  PreferencesState copyWith({
    Set<String>? contentPreferences,
    Set<String>? sizes,
    Set<String>? shoeSizes,
  }) {
    return PreferencesState(
      contentPreferences: contentPreferences ?? this.contentPreferences,
      sizes: sizes ?? this.sizes,
      shoeSizes: shoeSizes ?? this.shoeSizes,
    );
  }
}
