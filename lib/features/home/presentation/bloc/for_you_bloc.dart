// lib/features/home/presentation/bloc/for_you_bloc.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/entities/feed_section.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_event.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_state.dart';

class ForYouBloc extends Bloc<ForYouEvent, ForYouState> {
  ForYouBloc() : super(ForYouState.initial()) {
    on<LoadForYouFeed>(_onLoadForYouFeed);
  }

  void _onLoadForYouFeed(LoadForYouFeed event, Emitter<ForYouState> emit) {
    // Later this will call the use case to fetch from API
    emit(state.copyWith(sections: _placeholderSections()));
  }

  // Placeholder data — replace with use case call when API is ready
  List<FeedSection> _placeholderSections() {
    final okhtein = Brand(name: 'Okhtein', initials: 'OK', country: Country.egypt, categories: [BrandCategory.bags, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: true);
    final reemami = Brand(name: 'Reemami', initials: 'RE', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: false);
    final emergencyRoom = Brand(name: 'Emergency Room Beirut', initials: 'ER', country: Country.lebanon, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.lebanon], isFavorited: false);
    final dalya = Brand(name: 'Dalya', initials: 'DA', country: Country.egypt, categories: [BrandCategory.womenswear, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: false);

    return [
      FeedSection(
        title: 'Browse styles',
        looks: [
          Look(imageUrl: '', styleTag: 'Night Out', brand: okhtein, color: Colors.white),
          Look(imageUrl: '', styleTag: 'Birthday', brand: reemami, color: Colors.brown),
          Look(imageUrl: '', styleTag: 'Casual', brand: emergencyRoom, color: Colors.green),
          Look(imageUrl: '', styleTag: 'Romantic', brand: dalya, color: Colors.deepPurple),
        ],
      ),
      FeedSection(
        title: 'Spring Hues',
        looks: [
          Look(imageUrl: '', styleTag: 'Pastel Layers', brand: reemami, color: Colors.pink.shade100),
          Look(imageUrl: '', styleTag: 'Garden Party', brand: dalya, color: Colors.teal),
          Look(imageUrl: '', styleTag: 'Soft Linen', brand: emergencyRoom, color: Colors.amber),
          Look(imageUrl: '', styleTag: 'Floral Mix', brand: okhtein, color: Colors.indigo),
        ],
      ),
      FeedSection(
        title: 'Heatwave Minimalism',
        looks: [
          Look(imageUrl: '', styleTag: 'Neutral Tones', brand: dalya, color: Colors.grey),
          Look(imageUrl: '', styleTag: 'Clean Lines', brand: reemami, color: Colors.blueGrey),
          Look(imageUrl: '', styleTag: 'Sheer Layers', brand: emergencyRoom, color: Colors.lime),
          Look(imageUrl: '', styleTag: 'Monochrome', brand: okhtein, color: Colors.black54),
        ],
      ),
    ];
  }
}
