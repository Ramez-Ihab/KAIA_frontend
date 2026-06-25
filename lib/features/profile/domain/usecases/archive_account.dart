import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';

class ArchiveAccount extends UseCase<void, NoParams> {
  final ProfileRepository repository;

  ArchiveAccount(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.archiveAccount();
  }
}