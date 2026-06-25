import 'package:kaia/core/constants/country.dart';
abstract class LocationRepository {
  Future<List<Country>> getCountries();
  Future<void> setUserLocation(Country country);
  Future<Country?> getUserLocation();
}