import 'package:flutter/material.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/entities/feed_section.dart';
import 'package:kaia/features/home/domain/entities/featured_item.dart';
import 'package:kaia/features/home/domain/entities/mood_item.dart';

abstract class HomeLocalDataSource {
  Future<List<FeedSection>> getForYouFeed();
  Future<FeaturedItem> getFeaturedItem();
  Future<List<MoodItem>> getMoodItems();
  Future<List<Look>> getTrendingLooks();
  Future<List<Look>> getArrivalLooks();
}

class FakeHomeLocalDataSource implements HomeLocalDataSource {
  // Shared brand instances across all feeds
  static final _okhtein = Brand(name: 'Okhtein', initials: 'OK', country: Country.egypt, categories: [BrandCategory.bags, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: true);
  static final _reemami = Brand(name: 'Reemami', initials: 'RE', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]);
  static final _emergencyRoom = Brand(name: 'Emergency Room Beirut', initials: 'ER', country: Country.lebanon, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.lebanon]);
  static final _dalya = Brand(name: 'Dalya', initials: 'DA', country: Country.egypt, categories: [BrandCategory.womenswear, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt]);
  static final _lafshar = Brand(name: "L\'Afshar", initials: 'LA', country: Country.egypt, categories: [BrandCategory.bags], websiteUrl: '', shipsTo: [Country.egypt]);
  static final _irthJewels = Brand(name: 'Irth Jewels', initials: 'IJ', country: Country.uae, categories: [BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.uae]);
  static final _baynoire = Brand(name: 'Baynoire', initials: 'BA', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]);

  @override
  Future<List<FeedSection>> getForYouFeed() async => [
    FeedSection(title: 'Browse styles', looks: [
      Look(imageUrl: '', styleTag: 'Night Out', brand: _okhtein, color: Colors.white),
      Look(imageUrl: '', styleTag: 'Birthday', brand: _reemami, color: Colors.brown),
      Look(imageUrl: '', styleTag: 'Casual', brand: _emergencyRoom, color: Colors.green),
      Look(imageUrl: '', styleTag: 'Romantic', brand: _dalya, color: Colors.deepPurple),
    ]),
    FeedSection(title: 'Spring Hues', looks: [
      Look(imageUrl: '', styleTag: 'Pastel Layers', brand: _reemami, color: Colors.pink.shade100),
      Look(imageUrl: '', styleTag: 'Garden Party', brand: _dalya, color: Colors.teal),
      Look(imageUrl: '', styleTag: 'Soft Linen', brand: _emergencyRoom, color: Colors.amber),
      Look(imageUrl: '', styleTag: 'Floral Mix', brand: _okhtein, color: Colors.indigo),
    ]),
    FeedSection(title: 'Heatwave Minimalism', looks: [
      Look(imageUrl: '', styleTag: 'Neutral Tones', brand: _dalya, color: Colors.grey),
      Look(imageUrl: '', styleTag: 'Clean Lines', brand: _reemami, color: Colors.blueGrey),
      Look(imageUrl: '', styleTag: 'Sheer Layers', brand: _emergencyRoom, color: Colors.lime),
      Look(imageUrl: '', styleTag: 'Monochrome', brand: _okhtein, color: Colors.black54),
    ]),
  ];

  @override
  Future<FeaturedItem> getFeaturedItem() async => FeaturedItem(
    look: Look(imageUrl: '', styleTag: "Resort Season '26", brand: _reemami, color: const Color.fromARGB(255, 24, 43, 184)),
    looksCount: 54,
  );

  @override
  Future<List<MoodItem>> getMoodItems() async => const [
    MoodItem(title: 'Night Out', color: Colors.amberAccent),
    MoodItem(title: 'Minimal', color: Colors.cyan),
    MoodItem(title: 'Casual Chic', color: Colors.pink),
    MoodItem(title: 'Streetwear', color: Color(0xFF6C5341)),
  ];

  @override
  Future<List<Look>> getTrendingLooks() async => [
    Look(imageUrl: '', styleTag: 'Linen Sets', brand: _reemami, color: Colors.white),
    Look(imageUrl: '', styleTag: 'Boho Bags', brand: _lafshar, color: Colors.brown),
    Look(imageUrl: '', styleTag: 'Effortless Black', brand: _emergencyRoom, color: Colors.green),
    Look(imageUrl: '', styleTag: 'Summer Florals', brand: _dalya, color: Colors.deepPurple),
  ];

  @override
  Future<List<Look>> getArrivalLooks() async => [
    Look(imageUrl: '', styleTag: 'New drop', brand: _okhtein, color: Colors.white),
    Look(imageUrl: '', styleTag: 'SS26', brand: _reemami, color: Colors.brown),
    Look(imageUrl: '', styleTag: 'Limited', brand: _irthJewels, color: Colors.green),
    Look(imageUrl: '', styleTag: 'New', brand: _baynoire, color: Colors.deepPurple),
  ];
}
