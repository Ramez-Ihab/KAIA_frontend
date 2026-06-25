import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/entities/notification_settings.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class GetNotificationSettings extends UseCase<NotificationSettings, NoParams> {
  final ProfileRepository repository;

  GetNotificationSettings(this.repository);

  @override
  Future<NotificationSettings> call(NoParams params) {
    return repository.getNotificationSettings();
  }
}