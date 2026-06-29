import 'package:flutter/material.dart';
import 'package:kaia/core/theme/kaia_theme.dart';
import 'package:kaia/core/pages/main_page.dart';
import 'package:kaia/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_event.dart';
import 'package:kaia/features/search/presentation/bloc/search_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/home_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/discover_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/preferences_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/currency_bloc.dart';

void main() {
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SavedBloc>()),
        BlocProvider(create: (_) => sl<LocationBloc>()),
        BlocProvider(create: (_) => sl<BrandsBloc>()..add(LoadBrands())),
        BlocProvider(create: (_) => sl<HomeBloc>()),
        BlocProvider(create: (_) => sl<ForYouBloc>()),
        BlocProvider(create: (_) => sl<DiscoverBloc>()),
        BlocProvider(create: (_) => sl<SearchBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
        BlocProvider(create: (_) => sl<PreferencesBloc>()),
        BlocProvider(create: (_) => sl<CurrencyBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        theme: KaiaTheme.kaiaTheme,
        home: MainPage(),
      ),
    ),
  );
}