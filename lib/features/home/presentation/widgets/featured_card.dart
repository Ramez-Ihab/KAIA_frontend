import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/core/pages/see_all_page.dart';
import 'package:kaia/core/widgets/look_image.dart';
import 'package:kaia/features/home/domain/entities/featured_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';

class FeaturedCard extends StatelessWidget {
  final FeaturedItem featured;

  const FeaturedCard({super.key, required this.featured});

  @override
  Widget build(BuildContext context) {
    final look = featured.look;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SeeAllPage(title: look.styleTag, looks: featured.looks),
        ),
      ),
      child: Stack(
        children: [
          LookImage(
            look: look,
            width: 400,
            height: 350,
            borderRadius: BorderRadius.circular(29.0),
          ),
          Container(
            width: 400,
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withAlpha(150),
                ],
              ),
              borderRadius: BorderRadius.circular(29.0),
            ),
          ),
          Positioned(
            bottom: 44,
            left: 19,
            child: Text(
              look.styleTag,
              style: const TextStyle(
                fontSize: 24,
                color: Color(0xFFFFFFFF),
                fontFamily: 'GlacialIndifference',
              ),
            ),
          ),
          Positioned(bottom: 84, left: 19, child: Text('FEATURED', style: sectionLabel)),
          Positioned(
            bottom: 22,
            left: 19,
            child: Text('${featured.looksCount} looks curated this week', style: bodyText),
          ),
          Positioned(
            top: 18.0,
            right: 18.0,
            child: BlocBuilder<SavedBloc, SavedState>(
              builder: (context, state) {
                final isSaved = context.read<SavedBloc>().isLookSaved(look);
                return GestureDetector(
                  onTap: () => context.read<SavedBloc>().add(ToggleSaveItemEvent(look)),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
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
        ],
      ),
    );
  }
}
