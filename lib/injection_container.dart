import 'package:get_it/get_it.dart';

// Data sources
import 'package:kaia/features/home/data/datasources/home_local_data_source.dart';
import 'package:kaia/features/home/data/datasources/brand_local_data_source.dart';
import 'package:kaia/features/saved/data/datasources/saved_local_data_source.dart';
import 'package:kaia/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:kaia/features/location/data/datasources/location_local_data_source.dart';
import 'package:kaia/features/search/data/datasources/search_local_data_source.dart';

// Repository implementations
import 'package:kaia/features/home/data/repositories/home_repository_impl.dart';
import 'package:kaia/features/home/data/repositories/brand_repository_impl.dart';
import 'package:kaia/features/saved/data/repositories/saved_repository_impl.dart';
import 'package:kaia/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:kaia/features/location/data/repositories/location_repository_impl.dart';
import 'package:kaia/features/search/data/repositories/search_repository_impl.dart';

// Domain repositories (abstract)
import 'package:kaia/features/home/domain/repositories/home_repository.dart';
import 'package:kaia/features/home/domain/repositories/brand_repository.dart';
import 'package:kaia/features/saved/domain/repositories/saved_repository.dart';
import 'package:kaia/features/profile/domain/repositories/profile_repository.dart';
import 'package:kaia/features/location/domain/repositories/location_repository.dart';
import 'package:kaia/features/search/domain/repositories/search_repository.dart';

// Home use cases
import 'package:kaia/features/home/domain/usecases/get_for_you_feed.dart';
import 'package:kaia/features/home/domain/usecases/get_featured_look.dart.dart';
import 'package:kaia/features/home/domain/usecases/get_mood_categories.dart';
import 'package:kaia/features/home/domain/usecases/get_discover_feed.dart';
import 'package:kaia/features/home/domain/usecases/get_arrival_looks.dart';
import 'package:kaia/features/home/domain/usecases/get_brands_list.dart';
import 'package:kaia/features/home/domain/usecases/toggle_favorite_brand.dart';

// Saved use cases
import 'package:kaia/features/saved/domain/usecases/get_saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/toggle_save_item.dart';
import 'package:kaia/features/saved/domain/usecases/remove_saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/categorise_saved_item.dart';
import 'package:kaia/features/saved/domain/usecases/clear_item_category.dart';
import 'package:kaia/features/saved/domain/usecases/is_item_saved.dart';

// Profile use cases
import 'package:kaia/features/profile/domain/usecases/get_user_profile.dart';
import 'package:kaia/features/profile/domain/usecases/update_user_profile.dart';
import 'package:kaia/features/profile/domain/usecases/get_notification_settings.dart';
import 'package:kaia/features/profile/domain/usecases/update_notification_settings.dart';
import 'package:kaia/features/profile/domain/usecases/sign_out.dart';
import 'package:kaia/features/profile/domain/usecases/archive_account.dart';
import 'package:kaia/features/profile/domain/usecases/delete_account.dart';

// Location use cases
import 'package:kaia/features/location/domain/usecases/get_countries.dart';
import 'package:kaia/features/location/domain/usecases/set_user_location.dart';
import 'package:kaia/features/location/domain/usecases/get_user_location.dart';

// Search use cases
import 'package:kaia/features/search/domain/usecases/search_by_text.dart';
import 'package:kaia/features/search/domain/usecases/get_recent_searches.dart';
import 'package:kaia/features/search/domain/usecases/save_recent_search.dart';
import 'package:kaia/features/search/domain/usecases/remove_recent_search.dart';
import 'package:kaia/features/search/domain/usecases/clear_recent_searches.dart';

// BLoCs
import 'package:kaia/features/home/presentation/bloc/home_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/discover_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/preferences_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_bloc.dart';
import 'package:kaia/features/search/presentation/bloc/search_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // ── Data sources ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<HomeLocalDataSource>(() => FakeHomeLocalDataSource());
  sl.registerLazySingleton<BrandLocalDataSource>(() => FakeBrandLocalDataSource());
  sl.registerLazySingleton<SavedLocalDataSource>(() => FakeSavedLocalDataSource());
  sl.registerLazySingleton<ProfileLocalDataSource>(() => FakeProfileLocalDataSource());
  sl.registerLazySingleton<LocationLocalDataSource>(() => FakeLocationLocalDataSource());
  sl.registerLazySingleton<SearchLocalDataSource>(() => FakeSearchLocalDataSource());

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<BrandRepository>(() => BrandRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<SavedRepository>(() => SavedRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(dataSource: sl()));

  // ── Home use cases ────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetForYouFeed(sl()));
  sl.registerLazySingleton(() => GetFeaturedItem(sl()));
  sl.registerLazySingleton(() => GetMoodItems(sl()));
  sl.registerLazySingleton(() => GetTrendingLooks(sl()));
  sl.registerLazySingleton(() => GetArrivalLooks(sl()));
  sl.registerLazySingleton(() => GetBrandsList(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteBrand(sl()));

  // ── Saved use cases ───────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetSavedItems(sl()));
  sl.registerLazySingleton(() => ToggleSaveItem(sl()));
  sl.registerLazySingleton(() => RemoveSavedItem(sl()));
  sl.registerLazySingleton(() => CategoriseSavedItem(sl()));
  sl.registerLazySingleton(() => ClearItemCategory(sl()));
  sl.registerLazySingleton(() => IsItemSaved(sl()));

  // ── Profile use cases ─────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(() => UpdateUserProfile(sl()));
  sl.registerLazySingleton(() => GetNotificationSettings(sl()));
  sl.registerLazySingleton(() => UpdateNotificationSettings(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => ArchiveAccount(sl()));
  sl.registerLazySingleton(() => DeleteAccount(sl()));

  // ── Location use cases ────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetCountries(sl()));
  sl.registerLazySingleton(() => SetUserLocation(sl()));
  sl.registerLazySingleton(() => GetUserLocation(sl()));

  // ── Search use cases ──────────────────────────────────────────────────────
  sl.registerLazySingleton(() => SearchByText(sl()));
  sl.registerLazySingleton(() => GetRecentSearches(sl()));
  sl.registerLazySingleton(() => SaveRecentSearch(sl()));
  sl.registerLazySingleton(() => RemoveRecentSearch(sl()));
  sl.registerLazySingleton(() => ClearRecentSearches(sl()));

  // ── BLoCs ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => HomeBloc());
  sl.registerLazySingleton(() => ForYouBloc(getForYouFeed: sl()));
  sl.registerLazySingleton(() => DiscoverBloc(
        getFeaturedItem: sl(),
        getMoodItems: sl(),
        getTrendingLooks: sl(),
        getArrivalLooks: sl(),
      ));
  sl.registerLazySingleton(() => BrandsBloc(
        getBrandsList: sl(),
        toggleFavoriteBrand: sl(),
      ));
  sl.registerLazySingleton(() => SavedBloc(
        getSavedItems: sl(),
        toggleSaveItem: sl(),
        removeSavedItem: sl(),
        categoriseSavedItem: sl(),
        clearItemCategory: sl(),
        isItemSaved: sl(),
      ));
  sl.registerLazySingleton(() => ProfileBloc(
        getUserProfile: sl(),
        updateUserProfile: sl(),
        getNotificationSettings: sl(),
        updateNotificationSettings: sl(),
        signOut: sl(),
        archiveAccount: sl(),
        deleteAccount: sl(),
      ));
  sl.registerLazySingleton(() => PreferencesBloc());
  sl.registerLazySingleton(() => LocationBloc(
        getCountries: sl(),
        setUserLocation: sl(),
        getUserLocation: sl(),
      ));
  sl.registerLazySingleton(() => SearchBloc(
        searchByText: sl(),
        getRecentSearches: sl(),
        saveRecentSearch: sl(),
        removeRecentSearch: sl(),
        clearRecentSearches: sl(),
      ));
}
