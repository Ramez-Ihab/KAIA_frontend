import 'package:kaia/features/profile/domain/entities/user_profile.dart';
import 'package:kaia/features/profile/domain/entities/notification_settings.dart';
import 'package:kaia/features/profile/domain/entities/user_preferences.dart';
abstract class ProfileRepository {
  Future<UserProfile> getUserProfile();
  Future<void> updateUserProfile(UserProfile profile);
  Future<NotificationSettings> getNotificationSettings();
  Future<void> updateNotificationSettings(NotificationSettings settings);
  Future<UserPreferences> getUserPreferences();
  Future<void> updateUserPreferences(UserPreferences preferences);
  Future<void> changeEmail(String newEmail);
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> signOut();
  Future<void> archiveAccount();
  Future<void> deleteAccount();
}