import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/entities/user_profile.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfile extends UseCase<UserProfile, NoParams> {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  @override
  Future<UserProfile> call(NoParams params) {
    return repository.getUserProfile();
  }
}