import 'package:kaia/features/profile/domain/entities/notification_settings.dart';
import 'package:kaia/features/profile/domain/entities/user_preferences.dart';
import 'package:kaia/features/profile/domain/entities/user_profile.dart';

abstract class ProfileLocalDataSource {
  Future<UserProfile> getUserProfile();
  Future<void> updateUserProfile(UserProfile profile);
  Future<NotificationSettings> getNotificationSettings();
  Future<void> updateNotificationSettings(NotificationSettings settings);
  Future<UserPreferences> getUserPreferences();
  Future<void> updateUserPreferences(UserPreferences preferences);
  Future<void> signOut();
  Future<void> archiveAccount();
  Future<void> deleteAccount();
}

class FakeProfileLocalDataSource implements ProfileLocalDataSource {
  UserProfile _profile = UserProfile(
    id: '1',
    name: 'Your Name',
    username: 'username',
    avatarUrl: '',
    savedCount: 0,
    brandsCount: 0,
    categoriesCount: 0,
  );

  NotificationSettings _notifications = const NotificationSettings(
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
  );

  UserPreferences _preferences = const UserPreferences(
    contentPreferences: [],
    sizes: [],
    shoeSizes: [],
  );

  @override
  Future<UserProfile> getUserProfile() async => _profile;

  @override
  Future<void> updateUserProfile(UserProfile profile) async => _profile = profile;

  @override
  Future<NotificationSettings> getNotificationSettings() async => _notifications;

  @override
  Future<void> updateNotificationSettings(NotificationSettings settings) async => _notifications = settings;

  @override
  Future<UserPreferences> getUserPreferences() async => _preferences;

  @override
  Future<void> updateUserPreferences(UserPreferences preferences) async => _preferences = preferences;

  @override
  Future<void> signOut() async {}

  @override
  Future<void> archiveAccount() async {}

  @override
  Future<void> deleteAccount() async {}
}
