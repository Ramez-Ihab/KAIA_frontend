import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/entities/user_profile.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserProfile extends UseCase<void, UserProfile> {
  final ProfileRepository repository;

  UpdateUserProfile(this.repository);

  @override
  Future<void> call(UserProfile profile) {
    return repository.updateUserProfile(profile);
  }
}