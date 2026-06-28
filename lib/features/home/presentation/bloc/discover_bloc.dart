// lib/features/home/presentation/bloc/discover_bloc.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/entities/featured_item.dart';
import 'package:kaia/features/home/domain/entities/mood_item.dart';
import 'package:kaia/features/home/presentation/bloc/discover_event.dart';
import 'package:kaia/features/home/presentation/bloc/discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverState.initial()) {
    on<LoadDiscoverFeed>(_onLoadDiscoverFeed);
  }

  void _onLoadDiscoverFeed(LoadDiscoverFeed event, Emitter<DiscoverState> emit) {
    // Later this will call the use case to fetch from API
    final brands = _placeholderBrands();
    emit(state.copyWith(
      featured: _placeholderFeatured(brands['reemami']!),
      moods: _placeholderMoods(),
      trendingLooks: _placeholderTrending(brands),
      arrivalLooks: _placeholderArrivals(brands),
    ));
  }

  // Placeholder data — replace with use case call when API is ready
  Map<String, Brand> _placeholderBrands() => {
        'reemami': Brand(name: 'Reemami', initials: 'RE', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: false),
        'lafshar': Brand(name: "L'Afshar", initials: 'LA', country: Country.egypt, categories: [BrandCategory.bags], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: false),
        'emergencyRoom': Brand(name: 'Emergency Room Beirut', initials: 'ER', country: Country.lebanon, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.lebanon], isFavorited: false),
        'dalya': Brand(name: 'Dalya', initials: 'DA', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: false),
        'okhtein': Brand(name: 'Okhtein', initials: 'OK', country: Country.egypt, categories: [BrandCategory.bags, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: true),
        'irthJewels': Brand(name: 'Irth Jewels', initials: 'IJ', country: Country.uae, categories: [BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.uae], isFavorited: false),
        'baynoire': Brand(name: 'Baynoire', initials: 'BA', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: false),
      };

  FeaturedItem _placeholderFeatured(Brand reemami) => FeaturedItem(
        look: Look(imageUrl: '', styleTag: "Resort Season '26", brand: reemami, color: const Color.fromARGB(255, 24, 43, 184)),
        looksCount: 54,
      );

  List<MoodItem> _placeholderMoods() => const [
        MoodItem(title: 'Night Out', color: Colors.amberAccent),
        MoodItem(title: 'Minimal', color: Colors.cyan),
        MoodItem(title: 'Casual Chic', color: Colors.pink),
        MoodItem(title: 'Streetwear', color: Color(0xFF6C5341)),
      ];

  List<Look> _placeholderTrending(Map<String, Brand> b) => [
        Look(imageUrl: '', styleTag: 'Linen Sets', brand: b['reemami']!, color: Colors.white),
        Look(imageUrl: '', styleTag: 'Boho Bags', brand: b['lafshar']!, color: Colors.brown),
        Look(imageUrl: '', styleTag: 'Effortless Black', brand: b['emergencyRoom']!, color: Colors.green),
        Look(imageUrl: '', styleTag: 'Summer Florals', brand: b['dalya']!, color: Colors.deepPurple),
      ];

  List<Look> _placeholderArrivals(Map<String, Brand> b) => [
        Look(imageUrl: '', styleTag: 'New drop', brand: b['okhtein']!, color: Colors.white),
        Look(imageUrl: '', styleTag: 'SS26', brand: b['reemami']!, color: Colors.brown),
        Look(imageUrl: '', styleTag: 'Limited', brand: b['irthJewels']!, color: Colors.green),
        Look(imageUrl: '', styleTag: 'New', brand: b['baynoire']!, color: Colors.deepPurple),
      ];
}
