import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
class HorizontalCardSection extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final List<Widget> cards;
  final VoidCallback? onSeeAllTap;

  const HorizontalCardSection({
    super.key,
    required this.title,
    required this.cards,
    this.style,
    required this.onSeeAllTap,
  });

 @override
  Widget build(BuildContext context) {
   
    return Column(crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:[Text(title,style: style ?? sectionHeader ),TextButton(onPressed: (onSeeAllTap) , child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8.0, 0), child: Text('See all >',style: linkText)))],),
        SizedBox(height: 19),
        SizedBox(
          height: 250, 
          child:ListView.separated(
                  itemCount: cards.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => cards[index],
            separatorBuilder: (context, index) => SizedBox(width: 12),
            ))]);
      
  }}