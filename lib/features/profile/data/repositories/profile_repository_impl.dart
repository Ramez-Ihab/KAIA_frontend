import 'package:kaia/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:kaia/features/profile/domain/entities/notification_settings.dart';
import 'package:kaia/features/profile/domain/entities/user_preferences.dart';
import 'package:kaia/features/profile/domain/entities/user_profile.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<UserProfile> getUserProfile() => dataSource.getUserProfile();

  @override
  Future<void> updateUserProfile(UserProfile profile) =>
      dataSource.updateUserProfile(profile);

  @override
  Future<NotificationSettings> getNotificationSettings() =>
      dataSource.getNotificationSettings();

  @override
  Future<void> updateNotificationSettings(NotificationSettings settings) =>
      dataSource.updateNotificationSettings(settings);

  @override
  Future<UserPreferences> getUserPreferences() => dataSource.getUserPreferences();

  @override
  Future<void> updateUserPreferences(UserPreferences preferences) =>
      dataSource.updateUserPreferences(preferences);

  @override
  Future<void> changeEmail(String newEmail) async {}

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {}

  @override
  Future<void> signOut() => dataSource.signOut();

  @override
  Future<void> archiveAccount() => dataSource.archiveAccount();

  @override
  Future<void> deleteAccount() => dataSource.deleteAccount();
}
