import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class ChangeEmail extends UseCase<void, String> {
  final ProfileRepository repository;

  ChangeEmail(this.repository);

  @override
  Future<void> call(String newEmail) {
    return repository.changeEmail(newEmail);
  }
}