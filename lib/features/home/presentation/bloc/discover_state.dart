// lib/features/home/presentation/bloc/discover_state.dart

import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/entities/featured_item.dart';
import 'package:kaia/features/home/domain/entities/mood_item.dart';

class DiscoverState {
  final FeaturedItem? featured;
  final List<MoodItem> moods;
  final List<Look> trendingLooks;
  final List<Look> arrivalLooks;

  const DiscoverState({
    required this.featured,
    required this.moods,
    required this.trendingLooks,
    required this.arrivalLooks,
  });

  factory DiscoverState.initial() => const DiscoverState(
        featured: null,
        moods: [],
        trendingLooks: [],
        arrivalLooks: [],
      );

  DiscoverState copyWith({
    FeaturedItem? featured,
    List<MoodItem>? moods,
    List<Look>? trendingLooks,
    List<Look>? arrivalLooks,
  }) {
    return DiscoverState(
      featured: featured ?? this.featured,
      moods: moods ?? this.moods,
      trendingLooks: trendingLooks ?? this.trendingLooks,
      arrivalLooks: arrivalLooks ?? this.arrivalLooks,
    );
  }
}
