import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/widgets/look_image.dart';
import 'package:kaia/core/pages/look_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';

class TrendingCard extends StatelessWidget {
  final Look look;

  const TrendingCard({
    super.key,
    required this.look,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => LookPage.show(context, look),
      child: Stack(
        children: [
          LookImage(
            look: look,
            width: 170,
            height: 240,
            borderRadius: BorderRadius.circular(15.0),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            height: 240,
            width: 170,
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

          Positioned(bottom: 38, left: 16, right: 10, child: Text(look.styleTag, style: boldCardOverlay, maxLines: 2, overflow: TextOverflow.ellipsis)),
          Positioned(bottom: 22, left: 16, right: 10, child: Text(look.brand.name, style: bodyText, maxLines: 1, overflow: TextOverflow.ellipsis)),

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
        ],
      ),
    );
  }
}
