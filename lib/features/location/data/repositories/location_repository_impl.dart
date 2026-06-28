import 'package:kaia/core/constants/country.dart';
import 'package:kaia/features/location/data/datasources/location_local_data_source.dart';
import 'package:kaia/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource dataSource;

  LocationRepositoryImpl({required this.dataSource});

  @override
  Future<List<Country>> getCountries() => dataSource.getCountries();

  @override
  Future<void> setUserLocation(Country country) =>
      dataSource.setUserLocation(country);

  @override
  Future<Country?> getUserLocation() => dataSource.getUserLocation();
}
