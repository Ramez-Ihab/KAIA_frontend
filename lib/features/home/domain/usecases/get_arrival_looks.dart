import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class GetArrivalLooks extends UseCase<List<Look>, NoParams> {
  final HomeRepository repository;

  GetArrivalLooks(this.repository);

  @override
  Future<List<Look>> call(NoParams params) {
    return repository.getArrivalLooks();
  }
}
