import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/features/location/domain/repositories/location_repository.dart';

class GetCountries extends UseCase<List<Country>, NoParams> {
  final LocationRepository repository;

  GetCountries(this.repository);

  @override
  Future<List<Country>> call(NoParams params) {
    return repository.getCountries();
  }
}