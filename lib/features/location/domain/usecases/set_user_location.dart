import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/features/location/domain/repositories/location_repository.dart';

class SetUserLocation extends UseCase<void, Country> {
  final LocationRepository repository;

  SetUserLocation(this.repository);

  @override
  Future<void> call(Country country) {
    return repository.setUserLocation(country);
  }
}