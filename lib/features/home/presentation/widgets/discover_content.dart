import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/features/home/presentation/widgets/featured_card.dart';
import 'package:kaia/features/home/presentation/widgets/horizontal_card_section.dart';
import 'package:kaia/features/home/presentation/widgets/mood_card.dart';
import 'package:kaia/features/home/presentation/widgets/trending_card.dart';
import 'package:kaia/features/home/presentation/widgets/arrival_card.dart';
import 'package:kaia/core/pages/see_all_page.dart';

class DiscoverContent extends StatelessWidget {
  const DiscoverContent({super.key});

  @override
  Widget build(BuildContext context) {

    final reemami = Brand(
      name: 'Reemami',
      initials: 'RE',
      country: Country.egypt,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    );

    final lafshar = Brand(
      name: "L'Afshar",
      initials: 'LA',
      country: Country.egypt,
      categories: [BrandCategory.bags],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    );

    final emergencyRoom = Brand(
      name: 'Emergency Room Beirut',
      initials: 'ER',
      country: Country.lebanon,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.lebanon],
      isFavorited: false,
    );

    final dalya = Brand(
      name: 'Dalya',
      initials: 'DA',
      country: Country.egypt,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    );

    final okhtein = Brand(
      name: 'Okhtein',
      initials: 'OK',
      country: Country.egypt,
      categories: [BrandCategory.bags, BrandCategory.jewellery],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: true,
    );

    final irthJewels = Brand(
      name: 'Irth Jewels',
      initials: 'IJ',
      country: Country.uae,
      categories: [BrandCategory.jewellery],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.uae],
      isFavorited: false,
    );

    final baynoire = Brand(
      name: 'Baynoire',
      initials: 'BA',
      country: Country.egypt,
      categories: [BrandCategory.womenswear],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    );

    final featuredLook = Look(
      imageUrl: '',
      styleTag: "Resort Season '26",
      brand: reemami,
      color: const Color.fromARGB(255, 24, 43, 184),
    );

    final trendingLooks = [
      Look(imageUrl: '', styleTag: 'Linen Sets', brand: reemami, color: const Color.fromARGB(255, 255, 255, 255)),
      Look(imageUrl: '', styleTag: 'Boho Bags', brand: lafshar, color: Colors.brown),
      Look(imageUrl: '', styleTag: 'Effortless Black', brand: emergencyRoom, color: Colors.green),
      Look(imageUrl: '', styleTag: 'Summer Florals', brand: dalya, color: Colors.deepPurple),
    ];

    final arrivalLooks = [
      Look(imageUrl: '', styleTag: 'New drop', brand: okhtein, color: const Color.fromARGB(255, 255, 255, 255)),
      Look(imageUrl: '', styleTag: 'SS26', brand: reemami, color: Colors.brown),
      Look(imageUrl: '', styleTag: 'Limited', brand: irthJewels, color: Colors.green),
      Look(imageUrl: '', styleTag: 'New', brand: baynoire, color: Colors.deepPurple),
    ];

    final trendings = trendingLooks.map((look) =>
      TrendingCard(look: look),
    ).toList();

    final arrivals = arrivalLooks.map((look) =>
      ArrivalCard(look: look, chip: look.styleTag),
    ).toList();

    return SingleChildScrollView(child:
      Padding(padding: EdgeInsetsDirectional.fromSTEB(7.0, 20.0, 7.0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturedCard(look: featuredLook, looksnum: 54),
            SizedBox(height: 30),
            Text('Browse by mood', style: sectionHeader),
            SizedBox(height: 12),
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                MoodCard(color: Colors.amberAccent, title: 'Night Out'),
                SizedBox(width: 8),
                MoodCard(color: Colors.cyan, title: 'Minimal'),
              ]),
              SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                MoodCard(color: Colors.pink, title: 'Casual Chic'),
                SizedBox(width: 8),
                MoodCard(color: primaryColor, title: 'Streetwear'),
              ]),
            ]),
            HorizontalCardSection(title: 'Trending now', cards: trendings,onSeeAllTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SeeAllPage(title: 'Browse styles', looks: trendingLooks)))),
            HorizontalCardSection(title: 'New arrivals', cards: arrivals,onSeeAllTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SeeAllPage(title: 'Browse styles', looks: arrivalLooks)))),
          ],
        ),
      ),
    );
  }
}