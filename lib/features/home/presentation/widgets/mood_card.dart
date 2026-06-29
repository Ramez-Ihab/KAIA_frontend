import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/core/pages/see_all_page.dart';
import 'package:kaia/core/widgets/look_image.dart';
import 'package:kaia/features/home/domain/entities/mood_item.dart';

class MoodCard extends StatelessWidget {
  final MoodItem mood;

  const MoodCard({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SeeAllPage(title: mood.title, looks: mood.looks),
        ),
      ),
      child: Stack(
        children: [
          LookImage(
            look: mood.looks.first,
            width: 194,
            height: 194,
            borderRadius: BorderRadius.circular(15.0),
          ),
          Container(
            width: 194,
            height: 194,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withAlpha(150),
                ],
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(mood.title, style: cardOverlay, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
