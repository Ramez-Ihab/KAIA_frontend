import 'package:kaia/core/constants/country.dart';

abstract class LocationLocalDataSource {
  Future<List<Country>> getCountries();
  Future<void> setUserLocation(Country country);
  Future<Country?> getUserLocation();
}

class FakeLocationLocalDataSource implements LocationLocalDataSource {
  Country? _selectedCountry;

  @override
  Future<List<Country>> getCountries() async =>
      Country.values.where((c) => c != Country.all).toList();

  @override
  Future<void> setUserLocation(Country country) async => _selectedCountry = country;

  @override
  Future<Country?> getUserLocation() async => _selectedCountry;
}
