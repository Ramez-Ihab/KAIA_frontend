import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/entities/user_preferences.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserPreferences extends UseCase<void, UserPreferences> {
  final ProfileRepository repository;

  UpdateUserPreferences(this.repository);

  @override
  Future<void> call(UserPreferences preferences) {
    return repository.updateUserPreferences(preferences);
  }
}