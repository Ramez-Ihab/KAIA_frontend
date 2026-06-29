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
  static final _okhtein = Brand(name: 'Okhtein', initials: 'OK', country: Country.egypt, categories: [BrandCategory.bags, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: true);
  static final _reemami = Brand(name: 'Reemami', initials: 'RE', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]);
  static final _emergencyRoom = Brand(name: 'Emergency Room Beirut', initials: 'ER', country: Country.lebanon, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.lebanon]);
  static final _dalya = Brand(name: 'Dalya', initials: 'DA', country: Country.egypt, categories: [BrandCategory.womenswear, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt]);
  static final _lafshar = Brand(name: "L'Afshar", initials: 'LA', country: Country.egypt, categories: [BrandCategory.bags], websiteUrl: '', shipsTo: [Country.egypt]);
  static final _irthJewels = Brand(name: 'Irth Jewels', initials: 'IJ', country: Country.uae, categories: [BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.uae]);
  static final _baynoire = Brand(name: 'Baynoire', initials: 'BA', country: Country.egypt, categories: [BrandCategory.womenswear], websiteUrl: '', shipsTo: [Country.egypt]);

  // 10 test image URLs — cycled across all looks
  static const _u = [
    'https://plus.unsplash.com/premium_photo-1673287635614-15e7553f830d?q=80&w=687&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1531356495-75ccc754cb64?q=80&w=765&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1551029849-7e599391c0da?q=80&w=687&auto=format&fit=crop',
    'https://plus.unsplash.com/premium_photo-1755164638767-6596209e3d0b?q=80&w=687&auto=format&fit=crop',
    'https://plus.unsplash.com/premium_photo-1728657018900-5514f37fde59?q=80&w=688&auto=format&fit=crop',
    'https://plus.unsplash.com/premium_photo-1723924829722-76deb4448f67?q=80&w=632&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1667856642085-4a19aabd2793?q=80&w=687&auto=format&fit=crop',
    'https://plus.unsplash.com/premium_photo-1726098114653-51d316b10644?q=80&w=1170&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1545066230-919660a9290a?q=80&w=764&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1619326512511-c525c47d5acf?q=80&w=627&auto=format&fit=crop',
  ];

  @override
  Future<List<FeedSection>> getForYouFeed() async => [
    FeedSection(title: 'Browse styles', looks: [
      Look(imageUrl: _u[0], styleTag: 'Night Out', brand: _okhtein, color: Colors.white),
      Look(imageUrl: _u[1], styleTag: 'Birthday', brand: _reemami, color: Colors.brown),
      Look(imageUrl: _u[2], styleTag: 'Casual', brand: _emergencyRoom, color: Colors.green),
      Look(imageUrl: _u[3], styleTag: 'Romantic', brand: _dalya, color: Colors.deepPurple),
    ]),
    FeedSection(title: 'Spring Hues', looks: [
      Look(imageUrl: _u[4], styleTag: 'Pastel Layers', brand: _reemami, color: Colors.pink.shade100),
      Look(imageUrl: _u[5], styleTag: 'Garden Party', brand: _dalya, color: Colors.teal),
      Look(imageUrl: _u[6], styleTag: 'Soft Linen', brand: _emergencyRoom, color: Colors.amber),
      Look(imageUrl: _u[7], styleTag: 'Floral Mix', brand: _okhtein, color: Colors.indigo),
    ]),
    FeedSection(title: 'Heatwave Minimalism', looks: [
      Look(imageUrl: _u[8], styleTag: 'Neutral Tones', brand: _dalya, color: Colors.grey),
      Look(imageUrl: _u[9], styleTag: 'Clean Lines', brand: _reemami, color: Colors.blueGrey),
      Look(imageUrl: _u[0], styleTag: 'Sheer Layers', brand: _emergencyRoom, color: Colors.lime),
      Look(imageUrl: _u[1], styleTag: 'Monochrome', brand: _okhtein, color: Colors.black54),
    ]),
  ];

  @override
  Future<FeaturedItem> getFeaturedItem() async => FeaturedItem(
    looks: [
      Look(imageUrl: _u[2], styleTag: "Resort Season '26", brand: _reemami, color: const Color.fromARGB(255, 24, 43, 184)),
      Look(imageUrl: _u[3], styleTag: 'Coastal Edit', brand: _dalya, color: Colors.teal),
      Look(imageUrl: _u[4], styleTag: 'Sheer Layers', brand: _emergencyRoom, color: Colors.indigo),
      Look(imageUrl: _u[5], styleTag: 'Linen & Silk', brand: _okhtein, color: Colors.amber),
    ],
    looksCount: 54,
  );

  @override
  Future<List<MoodItem>> getMoodItems() async => [
    MoodItem(
      title: 'Night Out',
      color: Colors.amberAccent,
      looks: [
        Look(imageUrl: _u[0], styleTag: 'Night Out', brand: _okhtein, color: Colors.amberAccent),
        Look(imageUrl: _u[1], styleTag: 'After Dark', brand: _reemami, color: Colors.brown),
        Look(imageUrl: _u[2], styleTag: 'Glam', brand: _emergencyRoom, color: Colors.deepPurple),
      ],
    ),
    MoodItem(
      title: 'Minimal',
      color: Colors.cyan,
      looks: [
        Look(imageUrl: _u[3], styleTag: 'Clean Lines', brand: _reemami, color: Colors.cyan),
        Look(imageUrl: _u[4], styleTag: 'Neutral Tones', brand: _dalya, color: Colors.blueGrey),
        Look(imageUrl: _u[5], styleTag: 'Monochrome', brand: _okhtein, color: Colors.grey),
      ],
    ),
    MoodItem(
      title: 'Casual Chic',
      color: Colors.pink,
      looks: [
        Look(imageUrl: _u[6], styleTag: 'Effortless', brand: _dalya, color: Colors.pink),
        Look(imageUrl: _u[7], styleTag: 'Soft Linen', brand: _emergencyRoom, color: Colors.amber),
        Look(imageUrl: _u[8], styleTag: 'Garden Party', brand: _reemami, color: Colors.teal),
      ],
    ),
    MoodItem(
      title: 'Streetwear',
      color: const Color(0xFF6C5341),
      looks: [
        Look(imageUrl: _u[9], styleTag: 'Urban Edge', brand: _baynoire, color: const Color(0xFF6C5341)),
        Look(imageUrl: _u[0], styleTag: 'Bold Layers', brand: _okhtein, color: Colors.black54),
        Look(imageUrl: _u[1], styleTag: 'Statement', brand: _irthJewels, color: Colors.brown),
      ],
    ),
  ];

  @override
  Future<List<Look>> getTrendingLooks() async => [
    Look(imageUrl: _u[3], styleTag: 'Linen Sets', brand: _reemami, color: Colors.white),
    Look(imageUrl: _u[4], styleTag: 'Boho Bags', brand: _lafshar, color: Colors.brown),
    Look(imageUrl: _u[5], styleTag: 'Effortless Black', brand: _emergencyRoom, color: Colors.green),
    Look(imageUrl: _u[6], styleTag: 'Summer Florals', brand: _dalya, color: Colors.deepPurple),
  ];

  @override
  Future<List<Look>> getArrivalLooks() async => [
    Look(imageUrl: _u[7], styleTag: 'New drop', brand: _okhtein, color: Colors.white),
    Look(imageUrl: _u[8], styleTag: 'SS26', brand: _reemami, color: Colors.brown),
    Look(imageUrl: _u[9], styleTag: 'Limited', brand: _irthJewels, color: Colors.green),
    Look(imageUrl: _u[0], styleTag: 'New', brand: _baynoire, color: Colors.deepPurple),
  ];
}
