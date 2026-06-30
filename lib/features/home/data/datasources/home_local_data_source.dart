import 'package:flutter/material.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/entities/feed_section.dart';
import 'package:kaia/features/home/domain/entities/featured_item.dart';
import 'package:kaia/features/home/domain/entities/mood_item.dart';

// Shared image URLs — top-level so palettes can reference them
const _u0 = 'https://plus.unsplash.com/premium_photo-1673287635614-15e7553f830d?q=80&w=687&auto=format&fit=crop';
const _u1 = 'https://images.unsplash.com/photo-1531356495-75ccc754cb64?q=80&w=765&auto=format&fit=crop';
const _u2 = 'https://images.unsplash.com/photo-1551029849-7e599391c0da?q=80&w=687&auto=format&fit=crop';
const _u3 = 'https://plus.unsplash.com/premium_photo-1755164638767-6596209e3d0b?q=80&w=687&auto=format&fit=crop';
const _u4 = 'https://plus.unsplash.com/premium_photo-1728657018900-5514f37fde59?q=80&w=688&auto=format&fit=crop';
const _u5 = 'https://plus.unsplash.com/premium_photo-1723924829722-76deb4448f67?q=80&w=632&auto=format&fit=crop';
const _u6 = 'https://images.unsplash.com/photo-1667856642085-4a19aabd2793?q=80&w=687&auto=format&fit=crop';
const _u7 = 'https://plus.unsplash.com/premium_photo-1726098114653-51d316b10644?q=80&w=1170&auto=format&fit=crop';
const _u8 = 'https://images.unsplash.com/photo-1545066230-919660a9290a?q=80&w=764&auto=format&fit=crop';
const _u9 = 'https://images.unsplash.com/photo-1619326512511-c525c47d5acf?q=80&w=627&auto=format&fit=crop';

// Reusable color palettes — each color carries its own image set
const _neutrals = [
  LookColor(color: Color(0xFFF5F0EB), name: 'Ivory',    imageUrls: [_u0, _u1]),
  LookColor(color: Color(0xFFD4B89A), name: 'Camel',    imageUrls: [_u2, _u3]),
  LookColor(color: Color(0xFF3B3028), name: 'Espresso', imageUrls: [_u4, _u5]),
];
const _earthy = [
  LookColor(color: Color(0xFFB5836A), name: 'Terracotta', imageUrls: [_u3, _u4]),
  LookColor(color: Color(0xFF8C6E50), name: 'Mocha',      imageUrls: [_u5, _u6]),
  LookColor(color: Color(0xFF4A3728), name: 'Walnut',     imageUrls: [_u7, _u8]),
];
const _nights = [
  LookColor(color: Color(0xFF1A1A2E), name: 'Midnight', imageUrls: [_u6, _u7]),
  LookColor(color: Color(0xFF6B3FA0), name: 'Plum',     imageUrls: [_u8, _u9]),
  LookColor(color: Color(0xFFC0A060), name: 'Gold',     imageUrls: [_u0, _u2]),
];
const _pastels = [
  LookColor(color: Color(0xFFF4C2C2), name: 'Blush',    imageUrls: [_u1, _u3]),
  LookColor(color: Color(0xFFB5D5C5), name: 'Sage',     imageUrls: [_u5, _u7]),
  LookColor(color: Color(0xFFD4C5E2), name: 'Lavender', imageUrls: [_u9, _u0]),
];

abstract class HomeLocalDataSource {
  Future<List<FeedSection>> getForYouFeed();
  Future<FeaturedItem> getFeaturedItem();
  Future<List<MoodItem>> getMoodItems();
  Future<List<Look>> getTrendingLooks();
  Future<List<Look>> getArrivalLooks();
}

class FakeHomeLocalDataSource implements HomeLocalDataSource {
  static final _okhtein     = Brand(name: 'Okhtein',                initials: 'OK', country: Country.egypt,   categories: [BrandCategory.bags, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt], isFavorited: true);
  static final _reemami     = Brand(name: 'Reemami',                initials: 'RE', country: Country.egypt,   categories: [BrandCategory.womenswear],                     websiteUrl: '', shipsTo: [Country.egypt]);
  static final _emergencyRoom = Brand(name: 'Emergency Room Beirut', initials: 'ER', country: Country.lebanon, categories: [BrandCategory.womenswear],                     websiteUrl: '', shipsTo: [Country.lebanon]);
  static final _dalya       = Brand(name: 'Dalya',                  initials: 'DA', country: Country.egypt,   categories: [BrandCategory.womenswear, BrandCategory.jewellery], websiteUrl: '', shipsTo: [Country.egypt]);
  static final _lafshar     = Brand(name: "L'Afshar",               initials: 'LA', country: Country.egypt,   categories: [BrandCategory.bags],                           websiteUrl: '', shipsTo: [Country.egypt]);
  static final _irthJewels  = Brand(name: 'Irth Jewels',            initials: 'IJ', country: Country.uae,     categories: [BrandCategory.jewellery],                      websiteUrl: '', shipsTo: [Country.uae]);
  static final _baynoire    = Brand(name: 'Baynoire',               initials: 'BA', country: Country.egypt,   categories: [BrandCategory.womenswear],                     websiteUrl: '', shipsTo: [Country.egypt]);

  static const _u = [_u0, _u1, _u2, _u3, _u4, _u5, _u6, _u7, _u8, _u9];

  // Simple pool looks (no similarLooks) used as similar looks on main looks
  static final _pool = [
    Look(imageUrls: [_u[0], _u[1]], styleTag: 'Night Out',    brand: _okhtein,       color: Colors.amberAccent, price: 320,  colors: _nights,  sizes: [36, 38, 40, 42]),
    Look(imageUrls: [_u[2], _u[3]], styleTag: 'Casual',       brand: _emergencyRoom, color: Colors.green,       price: 180,  colors: _earthy,  sizes: [38, 40, 42, 44]),
    Look(imageUrls: [_u[4], _u[5]], styleTag: 'Pastel Layers',brand: _reemami,       color: Colors.pink,        price: 210,  colors: _pastels, sizes: [36, 38, 40]),
    Look(imageUrls: [_u[6], _u[7]], styleTag: 'Urban Edge',   brand: _baynoire,      color: Colors.black54,     price: 275,  colors: _nights,  sizes: [38, 40, 42, 44, 46]),
    Look(imageUrls: [_u[8], _u[9]], styleTag: 'Neutral Tones',brand: _dalya,         color: Colors.grey,        price: 195,  colors: _neutrals,sizes: [36, 38, 40, 42]),
    Look(imageUrls: [_u[1], _u[2]], styleTag: 'Garden Party', brand: _dalya,         color: Colors.teal,        price: 340,  colors: _pastels, sizes: [38, 40, 42]),
    Look(imageUrls: [_u[3], _u[4]], styleTag: 'Soft Linen',   brand: _emergencyRoom, color: Colors.amber,       price: 160,  colors: _neutrals,sizes: [36, 38, 40, 42, 44]),
    Look(imageUrls: [_u[5], _u[6]], styleTag: 'Floral Mix',   brand: _okhtein,       color: Colors.indigo,      price: 290,  colors: _pastels, sizes: [38, 40, 42]),
    Look(imageUrls: [_u[7], _u[8]], styleTag: 'Clean Lines',  brand: _reemami,       color: Colors.blueGrey,    price: 225,  colors: _neutrals,sizes: [36, 38, 40, 42]),
    Look(imageUrls: [_u[9], _u[0]], styleTag: 'Monochrome',   brand: _okhtein,       color: Colors.black54,     price: 310,  colors: _nights,  sizes: [38, 40, 42, 44]),
  ];

  @override
  Future<List<FeedSection>> getForYouFeed() async => [
    FeedSection(title: 'Browse styles', looks: [
      Look(imageUrls: [_u[0], _u[1], _u[2]], styleTag: 'Night Out',   brand: _okhtein,       color: Colors.white,       price: 450,  colors: _nights,   sizes: [36, 38, 40, 42],       similarLooks: [_pool[1], _pool[2], _pool[3]]),
      Look(imageUrls: [_u[1], _u[2]],        styleTag: 'Birthday',    brand: _reemami,       color: Colors.brown,       price: 320,  colors: _earthy,   sizes: [38, 40, 42, 44],       similarLooks: [_pool[0], _pool[4], _pool[5]]),
      Look(imageUrls: [_u[2], _u[3], _u[4]], styleTag: 'Casual',      brand: _emergencyRoom, color: Colors.green,       price: 180,  colors: _neutrals, sizes: [36, 38, 40, 42, 44],   similarLooks: [_pool[6], _pool[7], _pool[8]]),
      Look(imageUrls: [_u[3], _u[4]],        styleTag: 'Romantic',    brand: _dalya,         color: Colors.deepPurple,  price: 510,  colors: _pastels,  sizes: [38, 40, 42],           similarLooks: [_pool[9], _pool[0], _pool[1]]),
    ]),
    FeedSection(title: 'Spring Hues', looks: [
      Look(imageUrls: [_u[4], _u[5], _u[6]], styleTag: 'Pastel Layers', brand: _reemami,       color: Colors.pink,      price: 210,  colors: _pastels,  sizes: [36, 38, 40],           similarLooks: [_pool[2], _pool[3], _pool[4]]),
      Look(imageUrls: [_u[5], _u[6]],        styleTag: 'Garden Party',  brand: _dalya,         color: Colors.teal,      price: 340,  colors: _earthy,   sizes: [38, 40, 42, 44],       similarLooks: [_pool[5], _pool[6], _pool[7]]),
      Look(imageUrls: [_u[6], _u[7], _u[8]], styleTag: 'Soft Linen',    brand: _emergencyRoom, color: Colors.amber,     price: 160,  colors: _neutrals, sizes: [36, 38, 40, 42],       similarLooks: [_pool[8], _pool[9], _pool[0]]),
      Look(imageUrls: [_u[7], _u[8]],        styleTag: 'Floral Mix',    brand: _okhtein,       color: Colors.indigo,    price: 290,  colors: _nights,   sizes: [38, 40, 42, 44],       similarLooks: [_pool[1], _pool[2], _pool[3]]),
    ]),
    FeedSection(title: 'Heatwave Minimalism', looks: [
      Look(imageUrls: [_u[8], _u[9], _u[0]], styleTag: 'Neutral Tones', brand: _dalya,         color: Colors.grey,      price: 195,  colors: _neutrals, sizes: [36, 38, 40, 42, 44],   similarLooks: [_pool[4], _pool[5], _pool[6]]),
      Look(imageUrls: [_u[9], _u[0]],        styleTag: 'Clean Lines',   brand: _reemami,       color: Colors.blueGrey,  price: 225,  colors: _neutrals, sizes: [38, 40, 42],           similarLooks: [_pool[7], _pool[8], _pool[9]]),
      Look(imageUrls: [_u[0], _u[1], _u[2]], styleTag: 'Sheer Layers',  brand: _emergencyRoom, color: Colors.lime,      price: 380,  colors: _pastels,  sizes: [36, 38, 40, 42],       similarLooks: [_pool[0], _pool[1], _pool[2]]),
      Look(imageUrls: [_u[1], _u[2]],        styleTag: 'Monochrome',    brand: _okhtein,       color: Colors.black54,   price: 310,  colors: _nights,   sizes: [38, 40, 42, 44],       similarLooks: [_pool[3], _pool[4], _pool[5]]),
    ]),
  ];

  @override
  Future<FeaturedItem> getFeaturedItem() async => FeaturedItem(
    looks: [
      Look(imageUrls: [_u[2], _u[3], _u[4]], styleTag: "Resort Season '26", brand: _reemami,       color: const Color.fromARGB(255, 24, 43, 184), price: 620, colors: _pastels,  sizes: [36, 38, 40, 42],     similarLooks: [_pool[0], _pool[2], _pool[4]]),
      Look(imageUrls: [_u[3], _u[4]],        styleTag: 'Coastal Edit',      brand: _dalya,         color: Colors.teal,                            price: 480, colors: _neutrals, sizes: [38, 40, 42, 44],     similarLooks: [_pool[1], _pool[3], _pool[5]]),
      Look(imageUrls: [_u[4], _u[5], _u[6]], styleTag: 'Sheer Layers',      brand: _emergencyRoom, color: Colors.indigo,                          price: 390, colors: _nights,   sizes: [38, 40, 42],         similarLooks: [_pool[6], _pool[7], _pool[8]]),
      Look(imageUrls: [_u[5], _u[6]],        styleTag: 'Linen & Silk',      brand: _okhtein,       color: Colors.amber,                           price: 540, colors: _earthy,   sizes: [36, 38, 40, 42, 44], similarLooks: [_pool[9], _pool[0], _pool[2]]),
    ],
    looksCount: 54,
  );

  @override
  Future<List<MoodItem>> getMoodItems() async => [
    MoodItem(
      title: 'Night Out',
      color: Colors.amberAccent,
      looks: [
        Look(imageUrls: [_u[0], _u[1], _u[2]], styleTag: 'Night Out',  brand: _okhtein,       color: Colors.amberAccent, price: 450, colors: _nights,   sizes: [36, 38, 40, 42],     similarLooks: [_pool[1], _pool[3], _pool[5]]),
        Look(imageUrls: [_u[1], _u[2]],        styleTag: 'After Dark', brand: _reemami,       color: Colors.brown,       price: 320, colors: _nights,   sizes: [38, 40, 42, 44],     similarLooks: [_pool[0], _pool[4], _pool[6]]),
        Look(imageUrls: [_u[2], _u[3], _u[4]], styleTag: 'Glam',       brand: _emergencyRoom, color: Colors.deepPurple,  price: 510, colors: _earthy,   sizes: [38, 40, 42],         similarLooks: [_pool[7], _pool[8], _pool[9]]),
      ],
    ),
    MoodItem(
      title: 'Minimal',
      color: Colors.cyan,
      looks: [
        Look(imageUrls: [_u[3], _u[4]],        styleTag: 'Clean Lines',   brand: _reemami,   color: Colors.cyan,      price: 225, colors: _neutrals, sizes: [36, 38, 40, 42],     similarLooks: [_pool[2], _pool[4], _pool[6]]),
        Look(imageUrls: [_u[4], _u[5], _u[6]], styleTag: 'Neutral Tones', brand: _dalya,     color: Colors.blueGrey,  price: 195, colors: _neutrals, sizes: [38, 40, 42, 44],     similarLooks: [_pool[1], _pool[3], _pool[5]]),
        Look(imageUrls: [_u[5], _u[6]],        styleTag: 'Monochrome',    brand: _okhtein,   color: Colors.grey,      price: 310, colors: _nights,   sizes: [38, 40, 42],         similarLooks: [_pool[7], _pool[8], _pool[9]]),
      ],
    ),
    MoodItem(
      title: 'Casual Chic',
      color: Colors.pink,
      looks: [
        Look(imageUrls: [_u[6], _u[7], _u[8]], styleTag: 'Effortless',   brand: _dalya,         color: Colors.pink,   price: 270, colors: _pastels,  sizes: [36, 38, 40, 42],     similarLooks: [_pool[0], _pool[2], _pool[4]]),
        Look(imageUrls: [_u[7], _u[8]],        styleTag: 'Soft Linen',   brand: _emergencyRoom, color: Colors.amber,  price: 160, colors: _neutrals, sizes: [38, 40, 42, 44],     similarLooks: [_pool[1], _pool[3], _pool[5]]),
        Look(imageUrls: [_u[8], _u[9], _u[0]], styleTag: 'Garden Party', brand: _reemami,       color: Colors.teal,   price: 340, colors: _pastels,  sizes: [36, 38, 40],         similarLooks: [_pool[6], _pool[7], _pool[8]]),
      ],
    ),
    MoodItem(
      title: 'Streetwear',
      color: const Color(0xFF6C5341),
      looks: [
        Look(imageUrls: [_u[9], _u[0]],        styleTag: 'Urban Edge',   brand: _baynoire,   color: const Color(0xFF6C5341), price: 275, colors: _nights,   sizes: [38, 40, 42, 44],     similarLooks: [_pool[0], _pool[3], _pool[6]]),
        Look(imageUrls: [_u[0], _u[1], _u[2]], styleTag: 'Bold Layers',  brand: _okhtein,    color: Colors.black54,          price: 420, colors: _earthy,   sizes: [36, 38, 40, 42],     similarLooks: [_pool[1], _pool[4], _pool[7]]),
        Look(imageUrls: [_u[1], _u[2]],        styleTag: 'Statement',    brand: _irthJewels, color: Colors.brown,            price: 580, colors: _nights,   sizes: [38, 40, 42],         similarLooks: [_pool[2], _pool[5], _pool[8]]),
      ],
    ),
  ];

  @override
  Future<List<Look>> getTrendingLooks() async => [
    Look(imageUrls: [_u[3], _u[4], _u[5]], styleTag: 'Linen Sets',       brand: _reemami,       color: Colors.white,  price: 225, colors: _neutrals, sizes: [36, 38, 40, 42],     similarLooks: [_pool[0], _pool[2], _pool[4]]),
    Look(imageUrls: [_u[4], _u[5]],        styleTag: 'Boho Bags',        brand: _lafshar,       color: Colors.brown,  price: 390, colors: _earthy,   sizes: [38, 40, 42, 44],     similarLooks: [_pool[1], _pool[3], _pool[5]]),
    Look(imageUrls: [_u[5], _u[6], _u[7]], styleTag: 'Effortless Black', brand: _emergencyRoom, color: Colors.green,  price: 310, colors: _nights,   sizes: [38, 40, 42],         similarLooks: [_pool[6], _pool[7], _pool[8]]),
    Look(imageUrls: [_u[6], _u[7]],        styleTag: 'Summer Florals',   brand: _dalya,         color: Colors.purple, price: 195, colors: _pastels,  sizes: [36, 38, 40, 42],     similarLooks: [_pool[9], _pool[0], _pool[2]]),
  ];

  @override
  Future<List<Look>> getArrivalLooks() async => [
    Look(imageUrls: [_u[7], _u[8], _u[9]], styleTag: 'New drop', brand: _okhtein,    color: Colors.white,  price: 450, colors: _neutrals, sizes: [36, 38, 40, 42],     similarLooks: [_pool[1], _pool[3], _pool[5]]),
    Look(imageUrls: [_u[8], _u[9]],        styleTag: 'SS26',     brand: _reemami,    color: Colors.brown,  price: 320, colors: _earthy,   sizes: [38, 40, 42, 44],     similarLooks: [_pool[0], _pool[4], _pool[6]]),
    Look(imageUrls: [_u[9], _u[0], _u[1]], styleTag: 'Limited',  brand: _irthJewels, color: Colors.green,  price: 680, colors: _nights,   sizes: [38, 40, 42],         similarLooks: [_pool[7], _pool[8], _pool[9]]),
    Look(imageUrls: [_u[0], _u[1]],        styleTag: 'New',      brand: _baynoire,   color: Colors.purple, price: 275, colors: _pastels,  sizes: [36, 38, 40, 42],     similarLooks: [_pool[2], _pool[3], _pool[5]]),
  ];
}
