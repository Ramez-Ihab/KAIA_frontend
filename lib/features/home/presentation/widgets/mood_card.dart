import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';

class MoodCard extends StatelessWidget{
  final Color color;
  final String title;
  const MoodCard({
    super.key,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle card tap
      },
      child: Stack(children:[
                Container(
                clipBehavior: Clip.hardEdge,
                height: 194,
                width: 194,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                height: 194,
                width: 194,
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

              Positioned(bottom: 16, left: 16, child: Text(title,style: cardOverlay)),
            ]));
  }

}