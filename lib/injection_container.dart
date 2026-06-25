import 'package:get_it/get_it.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton(() => SavedBloc());
  sl.registerLazySingleton(() => LocationBloc());
  sl.registerLazySingleton(() => BrandsBloc());
}