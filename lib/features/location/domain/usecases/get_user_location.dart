import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/features/location/domain/repositories/location_repository.dart';

class GetUserLocation extends UseCase<Country?, NoParams> {
  final LocationRepository repository;

  GetUserLocation(this.repository);

  @override
  Future<Country?> call(NoParams params) {
    return repository.getUserLocation();
  }
}