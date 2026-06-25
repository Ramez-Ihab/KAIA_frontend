import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_event.dart';
import 'package:kaia/features/home/presentation/bloc/brands_state.dart';
import 'package:kaia/core/entities/brand.dart';

class FavouriteBrandsPage extends StatelessWidget {
  const FavouriteBrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocBuilder<BrandsBloc, BrandsState>(
                builder: (context, state) {
                  final favBrands = state.allBrands.where((b) => b.isFavorited).toList();

                  if (favBrands.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildBrandList(context, favBrands);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, size: 22),
          ),
          const SizedBox(width: 16),
          const Text(
            'Favourite brands',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'GlacialIndifference',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: darkgreyColor.withValues(alpha:0.1),
            ),
            child: Icon(
              Icons.favorite_border,
              size: 30,
              color: darkgreyColor.withValues(alpha:0.5),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No favourites yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'GlacialIndifference',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the ♡ on any brand in the Brands tab to save it here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'GlacialIndifference',
              color: darkgreyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandList(BuildContext context, List<Brand> brands) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: brands.length,
      separatorBuilder: (_, _) =>
          Divider(height: 1, thickness: 0.5, color: darkgreyColor.withValues(alpha:0.15)),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Text(
                brands[index].name,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'GlacialIndifference',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.read<BrandsBloc>().add(ToggleFavoriteBrandByName(brands[index].name));
                },
                child: Icon(Icons.favorite, size: 20, color: primaryColor),
              ),
            ],
          ),
        );
      },
    );
  }
}