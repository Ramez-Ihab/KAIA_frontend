import 'package:kaia/core/entities/look.dart';

class FeaturedItem {
  final List<Look> looks; // first is the card's display look
  final int looksCount;   // shown on card ("54 looks curated this week")

  const FeaturedItem({required this.looks, required this.looksCount});

  Look get look => looks.first;
}
