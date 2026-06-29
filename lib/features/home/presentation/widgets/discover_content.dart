import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_text_styles.dart';
import 'package:kaia/features/home/presentation/bloc/discover_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/discover_event.dart';
import 'package:kaia/features/home/presentation/bloc/discover_state.dart';
import 'package:kaia/features/home/presentation/widgets/featured_card.dart';
import 'package:kaia/features/home/presentation/widgets/horizontal_card_section.dart';
import 'package:kaia/features/home/presentation/widgets/mood_card.dart';
import 'package:kaia/features/home/presentation/widgets/trending_card.dart';
import 'package:kaia/features/home/presentation/widgets/arrival_card.dart';
import 'package:kaia/core/pages/see_all_page.dart';

class DiscoverContent extends StatelessWidget {
  const DiscoverContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverBloc, DiscoverState>(
      builder: (context, state) {
        if (state.featured == null) {
          // Trigger load if not yet loaded
          context.read<DiscoverBloc>().add(LoadDiscoverFeed());
          return const SizedBox.shrink();
        }

        final trendingCards = state.trendingLooks
            .map((look) => TrendingCard(look: look))
            .toList();

        final arrivalCards = state.arrivalLooks
            .map((look) => ArrivalCard(look: look, chip: look.styleTag))
            .toList();

        // Build mood grid rows (2 per row)
        final moodRows = <Widget>[];
        for (int i = 0; i < state.moods.length; i += 2) {
          final hasNext = i + 1 < state.moods.length;
          moodRows.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MoodCard(mood: state.moods[i]),
              if (hasNext) ...[
                const SizedBox(width: 8),
                MoodCard(mood: state.moods[i + 1]),
              ],
            ],
          ));
          if (i + 2 < state.moods.length) moodRows.add(const SizedBox(height: 8));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(7.0, 20.0, 7.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FeaturedCard(featured: state.featured!),
                const SizedBox(height: 30),
                Text('Browse by mood', style: sectionHeader),
                const SizedBox(height: 12),
                Column(children: moodRows),
                HorizontalCardSection(
                  title: 'Trending now',
                  cards: trendingCards,
                  onSeeAllTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeeAllPage(title: 'Trending now', looks: state.trendingLooks),
                    ),
                  ),
                ),
                HorizontalCardSection(
                  title: 'New arrivals',
                  cards: arrivalCards,
                  onSeeAllTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeeAllPage(title: 'New arrivals', looks: state.arrivalLooks),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
