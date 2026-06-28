// lib/features/profile/presentation/bloc/profile_state.dart

import 'package:kaia/features/profile/domain/entities/user_profile.dart';
import 'package:kaia/features/profile/domain/entities/notification_settings.dart';
import 'package:kaia/features/profile/domain/entities/user_preferences.dart';

class ProfileState {
  final UserProfile profile;
  final NotificationSettings notifications;
  final UserPreferences preferences;

  ProfileState({
    required this.profile,
    required this.notifications,
    required this.preferences,
  });

  factory ProfileState.initial() {
    return ProfileState(
      profile: UserProfile(
        id: '1',
        name: 'Your Name',
        username: 'username',
        avatarUrl: '',
        savedCount: 0,
        brandsCount: 0,
        categoriesCount: 0,
      ),
      notifications: NotificationSettings(
        masterToggle: true,
        priceDrops: true,
        backInStock: true,
        newArrivals: true,
        newCollections: false,
        saleAlerts: true,
        orderShipping: true,
        recommendations: false,
        pushNotifications: true,
        email: false,
      ),
      preferences: UserPreferences(
        contentPreferences: [],
        sizes: [],
        shoeSizes: [],
      ),
    );
  }

  ProfileState copyWith({
    UserProfile? profile,
    NotificationSettings? notifications,
    UserPreferences? preferences,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      notifications: notifications ?? this.notifications,
      preferences: preferences ?? this.preferences,
    );
  }
}