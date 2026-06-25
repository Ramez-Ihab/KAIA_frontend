// lib/core/widgets/look_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/widgets/brand_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';

class LookBottomSheet extends StatelessWidget {
  final Look look;

  const LookBottomSheet({
    super.key,
    required this.look,
  });

  static void show(BuildContext context, Look look) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => LookBottomSheet(look: look),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: darkgreyColor.withValues(alpha:0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Look image
            Container(
              width: double.infinity,
              height: 350,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: look.color ?? darkgreyColor.withValues(alpha:0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              // Replace with Image.network later
            ),
            const SizedBox(height: 16),

            // Style tag + brand info + save button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          look.styleTag.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'GlacialIndifference',
                            fontWeight: FontWeight.w600,
                            color: darkgreyColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          look.brand.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'GlacialIndifference',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${look.brand.categories.map((c) => c.label).join(', ')} · ${look.brand.country.label}',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'GlacialIndifference',
                            color: darkgreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<SavedBloc, SavedState>(
  builder: (context, state) {
    final isSaved = context.read<SavedBloc>().isLookSaved(look);
    return GestureDetector(
      onTap: () {
        context.read<SavedBloc>().add(ToggleSaveItemEvent(look));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSaved ? primaryColor : Colors.transparent,
          border: Border.all(
            color: isSaved ? primaryColor : darkgreyColor.withValues(alpha:0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              size: 18,
              color: isSaved ? Colors.white : darkgreyColor,
            ),
            const SizedBox(width: 4),
            Text(
              isSaved ? 'Saved' : 'Save',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'GlacialIndifference',
                fontWeight: FontWeight.w600,
                color: isSaved ? Colors.white : darkgreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  },
),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // View brand button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    BrandBottomSheet.show(context, look.brand);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'View brand',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Visit website button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Open external URL later
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: darkgreyColor.withValues(alpha:0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Visit website',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'GlacialIndifference',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.open_in_new, size: 16, color: darkgreyColor),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}