// lib/features/profile/presentation/bloc/profile_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_event.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_state.dart';
import 'package:kaia/features/profile/domain/entities/notification_settings.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateName>(_onUpdateName);
    on<UpdateUsername>(_onUpdateUsername);
    on<UpdateNotificationSetting>(_onUpdateNotificationSetting);
    on<UpdateContentPreferences>(_onUpdateContentPreferences);
    on<UpdateSizes>(_onUpdateSizes);
    on<UpdateShoeSizes>(_onUpdateShoeSizes);
    on<SignOutEvent>(_onSignOut);
    on<ArchiveAccountEvent>(_onArchiveAccount);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) {
    // Later this will call the use case
    emit(state);
  }

  void _onUpdateName(UpdateName event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      profile: state.profile.copyWith(name: event.name),
    ));
  }

  void _onUpdateUsername(UpdateUsername event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      profile: state.profile.copyWith(username: event.username),
    ));
  }

  void _onUpdateNotificationSetting(UpdateNotificationSetting event, Emitter<ProfileState> emit) {
    final current = state.notifications;
    NotificationSettings updated;

    switch (event.setting) {
      case 'masterToggle':
        updated = current.copyWith(masterToggle: event.value);
        break;
      case 'priceDrops':
        updated = current.copyWith(priceDrops: event.value);
        break;
      case 'backInStock':
        updated = current.copyWith(backInStock: event.value);
        break;
      case 'newArrivals':
        updated = current.copyWith(newArrivals: event.value);
        break;
      case 'newCollections':
        updated = current.copyWith(newCollections: event.value);
        break;
      case 'saleAlerts':
        updated = current.copyWith(saleAlerts: event.value);
        break;
      case 'orderShipping':
        updated = current.copyWith(orderShipping: event.value);
        break;
      case 'recommendations':
        updated = current.copyWith(recommendations: event.value);
        break;
      case 'pushNotifications':
        updated = current.copyWith(pushNotifications: event.value);
        break;
      case 'email':
        updated = current.copyWith(email: event.value);
        break;
      default:
        updated = current;
    }

    emit(state.copyWith(notifications: updated));
  }

  void _onUpdateContentPreferences(UpdateContentPreferences event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      preferences: state.preferences.copyWith(contentPreferences: event.preferences),
    ));
  }

  void _onUpdateSizes(UpdateSizes event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      preferences: state.preferences.copyWith(sizes: event.sizes),
    ));
  }

  void _onUpdateShoeSizes(UpdateShoeSizes event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      preferences: state.preferences.copyWith(shoeSizes: event.shoeSizes),
    ));
  }

  void _onSignOut(SignOutEvent event, Emitter<ProfileState> emit) {
    // Later this will call the use case and navigate to login
    emit(ProfileState.initial());
  }

  void _onArchiveAccount(ArchiveAccountEvent event, Emitter<ProfileState> emit) {
    // Later this will call the use case
  }

  void _onDeleteAccount(DeleteAccountEvent event, Emitter<ProfileState> emit) {
    // Later this will call the use case
  }
}