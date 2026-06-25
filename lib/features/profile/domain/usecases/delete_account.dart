import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class DeleteAccount extends UseCase<void, NoParams> {
  final ProfileRepository repository;

  DeleteAccount(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.deleteAccount();
  }
}