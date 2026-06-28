// lib/features/home/presentation/bloc/home_state.dart

class HomeState {
  final int activeTabIndex;
  final bool shipsToMeEnabled;
  final bool showBanner;

  const HomeState({
    required this.activeTabIndex,
    required this.shipsToMeEnabled,
    required this.showBanner,
  });

  factory HomeState.initial() => const HomeState(
        activeTabIndex: 0,
        shipsToMeEnabled: false,
        showBanner: true,
      );

  HomeState copyWith({
    int? activeTabIndex,
    bool? shipsToMeEnabled,
    bool? showBanner,
  }) {
    return HomeState(
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      shipsToMeEnabled: shipsToMeEnabled ?? this.shipsToMeEnabled,
      showBanner: showBanner ?? this.showBanner,
    );
  }
}
