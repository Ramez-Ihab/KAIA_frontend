import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams({required this.oldPassword, required this.newPassword});
}

class ChangePassword extends UseCase<void, ChangePasswordParams> {
  final ProfileRepository repository;

  ChangePassword(this.repository);

  @override
  Future<void> call(ChangePasswordParams params) {
    return repository.changePassword(params.oldPassword, params.newPassword);
  }
}