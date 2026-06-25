import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/core/entities/look.dart';
import 'package:kaia/core/widgets/look_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_event.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';

class ArrivalCard extends StatelessWidget {
  final Look look;
  final String chip;

  const ArrivalCard({
    super.key,
    required this.look,
    required this.chip,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => LookBottomSheet.show(context, look),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 220,
                width: 144,
                decoration: BoxDecoration(
                  color: look.color,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                height: 220,
                width: 144,
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

              Positioned(
                top: 15,
                left: 18,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(chip, style: newChip),
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
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
            child: Text(look.brand.name, style: boldBrand),
          ),
        ],
      ),
    );
  }
}
