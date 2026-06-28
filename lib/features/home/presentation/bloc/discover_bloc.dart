import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/home/domain/usecases/get_featured_look.dart.dart';
import 'package:kaia/features/home/domain/usecases/get_mood_categories.dart';
import 'package:kaia/features/home/domain/usecases/get_discover_feed.dart';
import 'package:kaia/features/home/domain/usecases/get_arrival_looks.dart';
import 'package:kaia/features/home/presentation/bloc/discover_event.dart';
import 'package:kaia/features/home/presentation/bloc/discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetFeaturedItem getFeaturedItem;
  final GetMoodItems getMoodItems;
  final GetTrendingLooks getTrendingLooks;
  final GetArrivalLooks getArrivalLooks;

  DiscoverBloc({
    required this.getFeaturedItem,
    required this.getMoodItems,
    required this.getTrendingLooks,
    required this.getArrivalLooks,
  }) : super(DiscoverState.initial()) {
    on<LoadDiscoverFeed>(_onLoadDiscoverFeed);
  }

  Future<void> _onLoadDiscoverFeed(LoadDiscoverFeed event, Emitter<DiscoverState> emit) async {
    final featured = await getFeaturedItem(NoParams());
    final moods = await getMoodItems(NoParams());
    final trending = await getTrendingLooks(NoParams());
    final arrivals = await getArrivalLooks(NoParams());
    emit(state.copyWith(
      featured: featured,
      moods: moods,
      trendingLooks: trending,
      arrivalLooks: arrivals,
    ));
  }
}
