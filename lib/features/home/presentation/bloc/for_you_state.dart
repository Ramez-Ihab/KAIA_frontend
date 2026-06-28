// lib/features/home/presentation/bloc/for_you_state.dart

import 'package:kaia/features/home/domain/entities/feed_section.dart';

class ForYouState {
  final List<FeedSection> sections;

  const ForYouState({required this.sections});

  factory ForYouState.initial() => const ForYouState(sections: []);

  ForYouState copyWith({List<FeedSection>? sections}) {
    return ForYouState(sections: sections ?? this.sections);
  }
}
