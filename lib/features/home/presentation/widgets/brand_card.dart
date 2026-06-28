import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/entities/brand.dart';
import 'package:kaia/core/widgets/brand_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_event.dart';
import 'package:kaia/features/home/presentation/bloc/brands_state.dart';

class BrandCard extends StatelessWidget {
  final Brand brand;

  const BrandCard({
    super.key,
    required this.brand,
  });




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BrandBottomSheet.show(context, brand),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 10.0, 0, 0),
        child: Stack(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            Column(children: [
              const SizedBox(height: 100),
              const Divider(
                color: Color.fromARGB(255, 147, 137, 119),
                thickness: 0.5,
              ),
            ]),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 100,
              child: Center(
                child: Text(
                  brand.initials,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromARGB(255, 184, 172, 149)
                        .withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),

            // Heart toggle
            Positioned(top: 18,
right: 18,
child: BlocBuilder<BrandsBloc, BrandsState>(
  builder: (context, brandsState) {
    final isFav = context.read<BrandsBloc>().isBrandFavorited(brand.name);
    return GestureDetector(
      onTap: () {
        context.read<BrandsBloc>().add(ToggleFavoriteBrandByName(brand.name));
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav
            ? primaryColor
            : const Color.fromARGB(255, 184, 172, 149),
        size: 18,
      ),
    );
  },
),),

            Positioned(
              bottom: 80,
              right: 18,
              child: Text(
                brand.country.label.toUpperCase(),
                style: const TextStyle(
                  letterSpacing: 1,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 182, 168, 141),
                  fontFamily: 'GlacialIndifference',
                ),
              ),
            ),

            Positioned(
              bottom: 25,
              left: 10,
              child: Text(
                brand.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 116, 86, 30),
                  fontFamily: 'GlacialIndifference',
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                brand.categories.map((c) => c.label).join(', '),
                style: const TextStyle(
                  color: Color.fromARGB(255, 128, 118, 101),
                  fontFamily: 'GlacialIndifference',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
