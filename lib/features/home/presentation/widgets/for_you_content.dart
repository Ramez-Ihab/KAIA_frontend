import 'package:flutter/material.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/brand_category.dart';
import 'package:kaia/features/home/presentation/widgets/style_card.dart';
import 'package:kaia/features/home/presentation/widgets/horizontal_card_section.dart';
import 'package:kaia/core/pages/see_all_page.dart';

class ForYouContent extends StatelessWidget {
  const ForYouContent({super.key});

  @override
  Widget build(BuildContext context) {

    final okhtein = Brand(
      name: 'Okhtein',
      initials: 'OK',
      country: Country.egypt,
      categories: [BrandCategory.bags, BrandCategory.jewellery],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: true,
    );

    final reemami = Brand(
      name: 'Reemami',
      initials: 'RE',
      country: Country.egypt,
      categories: [BrandCategory.womenswear],
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
      categories: [BrandCategory.womenswear,BrandCategory.jewellery],
      websiteUrl: 'https://example.com',
      shipsTo: [Country.egypt],
      isFavorited: false,
    );

    final browseLooks = [
      Look(imageUrl: '', styleTag: 'Night Out', brand: okhtein, color: const Color.fromARGB(255, 255, 255, 255)),
      Look(imageUrl: '', styleTag: 'Birthday', brand: reemami, color: Colors.brown),
      Look(imageUrl: '', styleTag: 'Casual', brand: emergencyRoom, color: Colors.green),
      Look(imageUrl: '', styleTag: 'Romantic', brand: dalya, color: Colors.deepPurple),
    ];

    final springLooks = [
      Look(imageUrl: '', styleTag: 'Pastel Layers', brand: reemami, color: Colors.pink.shade100),
      Look(imageUrl: '', styleTag: 'Garden Party', brand: dalya, color: Colors.teal),
      Look(imageUrl: '', styleTag: 'Soft Linen', brand: emergencyRoom, color: Colors.amber),
      Look(imageUrl: '', styleTag: 'Floral Mix', brand: okhtein, color: Colors.indigo),
    ];

    final heatwaveLooks = [
      Look(imageUrl: '', styleTag: 'Neutral Tones', brand: dalya, color: Colors.grey),
      Look(imageUrl: '', styleTag: 'Clean Lines', brand: reemami, color: Colors.blueGrey),
      Look(imageUrl: '', styleTag: 'Sheer Layers', brand: emergencyRoom, color: Colors.lime),
      Look(imageUrl: '', styleTag: 'Monochrome', brand: okhtein, color: Colors.black54),
    ];

    final browseCards = browseLooks.map((look) => StyleCard(look: look)).toList();
    final springCards = springLooks.map((look) => StyleCard(look: look)).toList();
    final heatwaveCards = heatwaveLooks.map((look) => StyleCard(look: look)).toList();

    return SingleChildScrollView(child:
      Padding(padding: EdgeInsetsDirectional.fromSTEB(7.0, 7.0, 7, 0), child:
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontalCardSection(title: 'Browse styles', cards: browseCards,onSeeAllTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SeeAllPage(title: 'Browse styles', looks: browseLooks)))),

            HorizontalCardSection(title: 'Spring Hues', cards: springCards,onSeeAllTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SeeAllPage(title: 'Spring Hues', looks: springLooks)))),
            HorizontalCardSection(title: 'Heatwave Minimalism', cards: heatwaveCards,onSeeAllTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SeeAllPage(title: 'Heatwave Minimalism', looks: heatwaveLooks)))),
          ],
        ),
      ),
    );
  }
}