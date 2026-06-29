import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/widgets/look_image.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/core/widgets/look_bottom_sheet.dart';


class SavedGridCard extends StatelessWidget {
  final SavedItem item;
  final VoidCallback onCategoryTap;

  const SavedGridCard({
    super.key,
    required this.item,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
  onTap: () => LookBottomSheet.show(context, item.look),
  child:Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Layer 1 - Image
          Positioned.fill(child: LookImage(look: item.look)),

          // Layer 2 - Gradient overlay at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha:0.5),
                  ],
                ),
              ),
            ),
          ),

          // Layer 3 - Category chip top-left
          if (item.category != null)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0).withValues(alpha:0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.category!.label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'GlacialIndifference',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          // Layer 4 - Categorize icon top-right
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onCategoryTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha:0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.drive_file_move_outline,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Layer 5 - Brand name bottom-left
          Positioned(
            bottom: 12,
            left: 12,
            child: Text(
              item.look.brand.name,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'GlacialIndifference',
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}