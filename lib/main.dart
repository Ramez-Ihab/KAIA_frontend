import 'package:flutter/material.dart';
import 'package:kaia/core/theme/kaia_theme.dart';
import 'package:kaia/core/pages/main_page.dart';
import 'package:kaia/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_event.dart';

void main() {
  setupDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SavedBloc>()),
        BlocProvider(create: (_) => sl<LocationBloc>()),
        BlocProvider(create: (_) => sl<BrandsBloc>()..add(LoadBrands())),
      ],
      child: MaterialApp(
        theme: KaiaTheme.kaiaTheme,
        home: MainPage(),
      ),
    ),
  );
}