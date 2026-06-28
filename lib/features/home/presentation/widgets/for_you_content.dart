import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_event.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_state.dart';
import 'package:kaia/features/home/presentation/widgets/style_card.dart';
import 'package:kaia/features/home/presentation/widgets/horizontal_card_section.dart';
import 'package:kaia/core/pages/see_all_page.dart';

class ForYouContent extends StatelessWidget {
  const ForYouContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForYouBloc, ForYouState>(
      builder: (context, state) {
        if (state.sections.isEmpty) {
          // Trigger load if not yet loaded
          context.read<ForYouBloc>().add(LoadForYouFeed());
          return const SizedBox.shrink();
        }

        final sections = state.sections
            .map((section) => HorizontalCardSection(
                  title: section.title,
                  cards: section.looks.map((look) => StyleCard(look: look)).toList(),
                  onSeeAllTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeeAllPage(title: section.title, looks: section.looks),
                    ),
                  ),
                ))
            .toList();

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(7.0, 7.0, 7.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections,
            ),
          ),
        );
      },
    );
  }
}
