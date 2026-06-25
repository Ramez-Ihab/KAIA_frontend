import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/entities/user_preferences.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class GetUserPreferences extends UseCase<UserPreferences, NoParams> {
  final ProfileRepository repository;

  GetUserPreferences(this.repository);

  @override
  Future<UserPreferences> call(NoParams params) {
    return repository.getUserPreferences();
  }
}