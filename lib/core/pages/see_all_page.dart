// lib/core/pages/see_all_page.dart

import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/pages/look_page.dart';
import 'package:kaia/core/widgets/look_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';

class SeeAllPage extends StatelessWidget {
  final String title;
  final List<Look> looks;

  const SeeAllPage({
    super.key,
    required this.title,
    required this.looks,
  });

  @override
  Widget build(BuildContext context) {
    final leftLooks = <Look>[];
    final rightLooks = <Look>[];

    for (int i = 0; i < looks.length; i++) {
      if (i % 2 == 0) {
        leftLooks.add(looks[i]);
      } else {
        rightLooks.add(looks[i]);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 8, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // Item count
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Text(
                '${looks.length} looks',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'GlacialIndifference',
                  color: darkgreyColor,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Masonry grid
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: leftLooks.asMap().entries.map((entry) {
                          final isOddIndex = entry.key % 2 != 0;
                          return Padding(
                            padding: const EdgeInsets.only(right: 5, bottom: 10),
                            child: SizedBox(
                              height: isOddIndex ? 180 : 240,
                              child: _SeeAllCard(look: entry.value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: Column(
                          children: rightLooks.asMap().entries.map((entry) {
                            final isOddIndex = entry.key % 2 != 0;
                            return Padding(
                              padding: const EdgeInsets.only(left: 5, bottom: 10),
                              child: SizedBox(
                                height: isOddIndex ? 240 : 180,
                                child: _SeeAllCard(look: entry.value),
                              ),
                            );
                          }).toList(),
                        ),
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

class _SeeAllCard extends StatelessWidget {
  final Look look;

  const _SeeAllCard({required this.look});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => LookPage.show(context, look),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(child: LookImage(look: look)),

            // Gradient overlay
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
                      Colors.black.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),

            // Bookmark toggle
            Positioned(
              top: 10,
              right: 10,
              child: BlocBuilder<SavedBloc, SavedState>(
  builder: (context, state) {
    final isSaved = context.read<SavedBloc>().isLookSaved(look);
    return GestureDetector(
      onTap: () {
        context.read<SavedBloc>().add(ToggleSaveItemEvent(look));
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha:0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  },
),
            ),

            Positioned(
              bottom: 12,
              left: 12,
              right: 40,
              child: Text(
                look.styleTag,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'GlacialIndifference',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Positioned(
              bottom: 28,
              left: 12,
              right: 40,
              child: Text(
                look.brand.name,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'GlacialIndifference',
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}