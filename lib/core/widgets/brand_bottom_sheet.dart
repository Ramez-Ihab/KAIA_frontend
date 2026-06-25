// lib/core/widgets/brand_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_event.dart';
import 'package:kaia/features/home/presentation/bloc/brands_state.dart';

class BrandBottomSheet extends StatelessWidget {
  final Brand brand;

  const BrandBottomSheet({
    super.key,
    required this.brand,
  });

  static void show(BuildContext context, Brand brand) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BrandBottomSheet(brand: brand),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).padding.bottom + 20),
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

            // Close and heart row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 22),
                ),
                BlocBuilder<BrandsBloc, BrandsState>(
  builder: (context, brandsState) {
    final isFav = context.read<BrandsBloc>().isBrandFavorited(brand.name);
    return GestureDetector(
      onTap: () {
        context.read<BrandsBloc>().add(ToggleFavoriteBrandByName(brand.name));
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        size: 22,
        color: primaryColor,
      ),
    );
  },
),
              ],
            ),
            const SizedBox(height: 16),

            // Brand logo/initials
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFEADDCF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  brand.initials,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'GlacialIndifference',
                    color: darkgreyColor.withValues(alpha:0.4),
                  ),
                ),
              ),
            ),

            // Country label on the card
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  brand.country.label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'GlacialIndifference',
                    color: darkgreyColor.withValues(alpha:0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Brand name
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                brand.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'GlacialIndifference',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 2),

            // Country
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                brand.country.label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'GlacialIndifference',
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Category chips
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: brand.categories.map((cat) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkgreyColor.withValues(alpha:0.3)),
                    ),
                    child: Text(
                      cat.label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'GlacialIndifference',
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Ships to
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SHIPS TO',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w700,
                      color: darkgreyColor,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    brand.shipsTo.map((c) => c.label).join(', '),
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'GlacialIndifference',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Visit brand button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // Open external URL later
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFB8A88A),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.open_in_new, size: 16, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Visit ${brand.name}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'GlacialIndifference',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}