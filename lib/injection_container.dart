import 'package:get_it/get_it.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/home_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/discover_bloc.dart';
import 'package:kaia/features/search/presentation/bloc/search_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/preferences_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton(() => SavedBloc());
  sl.registerLazySingleton(() => LocationBloc());
  sl.registerLazySingleton(() => BrandsBloc());
  sl.registerLazySingleton(() => HomeBloc());
  sl.registerLazySingleton(() => ForYouBloc());
  sl.registerLazySingleton(() => DiscoverBloc());
  sl.registerLazySingleton(() => SearchBloc());
  sl.registerLazySingleton(() => ProfileBloc());
  sl.registerLazySingleton(() => PreferencesBloc());
}