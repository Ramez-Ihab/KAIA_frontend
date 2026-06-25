// lib/features/profile/domain/entities/user_preferences.dart

class UserPreferences {
  final List<String> contentPreferences;
  final List<String> sizes;
  final List<String> shoeSizes;

  const UserPreferences({
    required this.contentPreferences,
    required this.sizes,
    required this.shoeSizes,
  });

  UserPreferences copyWith({
    List<String>? contentPreferences,
    List<String>? sizes,
    List<String>? shoeSizes,
  }) {
    return UserPreferences(
      contentPreferences: contentPreferences ?? this.contentPreferences,
      sizes: sizes ?? this.sizes,
      shoeSizes: shoeSizes ?? this.shoeSizes,
    );
  }
}