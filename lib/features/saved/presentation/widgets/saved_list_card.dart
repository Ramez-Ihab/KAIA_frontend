import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/widgets/look_image.dart';
import 'package:kaia/features/saved/domain/entities/saved_item.dart';
import 'package:kaia/core/pages/look_page.dart';


class SavedListCard extends StatelessWidget {
  final SavedItem item;
  final VoidCallback onCategoryTap;
  final VoidCallback onExternalTap;

  const SavedListCard({
    super.key,
    required this.item,
    required this.onCategoryTap,
    required this.onExternalTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
  onTap: () => LookPage.show(context, item.look),
  child:Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: darkgreyColor.withValues(alpha:0.4),
          width: 0.8,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          // Left - Image filling left portion
          LookImage(look: item.look, width: 90, height: 90),

          // Middle - Brand name + category chip
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.look.brand.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: item.category != null
                          ? secondaryColor
                          : darkgreyColor.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.category?.label ?? 'Uncategorized',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w600,
                        color: item.category != null
                            ? primaryColor
                            : darkgreyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right - Action icons
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onExternalTap,
                  child: Icon(
                    Icons.open_in_new,
                    size: 18,
                    color: const Color.fromARGB(255, 0, 0, 0).withValues(alpha:0.6),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: onCategoryTap,
                  child: Icon(
                    Icons.drive_file_move_outline,
                    size: 18,
                    color: const Color.fromARGB(255, 0, 0, 0).withValues(alpha:0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}