// lib/features/home/presentation/bloc/home_event.dart

abstract class HomeEvent {}

class SetActiveTab extends HomeEvent {
  final int index;
  SetActiveTab(this.index);
}

class ToggleShipsToMe extends HomeEvent {}

class DismissBanner extends HomeEvent {}

// Fired when the user confirms a location — auto-dismisses banner and enables ships-to-me
class LocationConfirmed extends HomeEvent {}
