import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/entities/notification_settings.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class UpdateNotificationSettings extends UseCase<void, NotificationSettings> {
  final ProfileRepository repository;

  UpdateNotificationSettings(this.repository);

  @override
  Future<void> call(NotificationSettings settings) {
    return repository.updateNotificationSettings(settings);
  }
}