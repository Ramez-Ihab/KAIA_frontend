import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/profile/domain/entities/notification_settings.dart';
import 'package:kaia/features/profile/domain/usecases/archive_account.dart';
import 'package:kaia/features/profile/domain/usecases/delete_account.dart';
import 'package:kaia/features/profile/domain/usecases/get_notification_settings.dart';
import 'package:kaia/features/profile/domain/usecases/get_user_profile.dart';
import 'package:kaia/features/profile/domain/usecases/sign_out.dart';
import 'package:kaia/features/profile/domain/usecases/update_notification_settings.dart';
import 'package:kaia/features/profile/domain/usecases/update_user_profile.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_event.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_state.dart';
import 'package:kaia/core/usecases/usecase.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile getUserProfile;
  final UpdateUserProfile updateUserProfile;
  final GetNotificationSettings getNotificationSettings;
  final UpdateNotificationSettings updateNotificationSettings;
  final SignOut signOut;
  final ArchiveAccount archiveAccount;
  final DeleteAccount deleteAccount;

  ProfileBloc({
    required this.getUserProfile,
    required this.updateUserProfile,
    required this.getNotificationSettings,
    required this.updateNotificationSettings,
    required this.signOut,
    required this.archiveAccount,
    required this.deleteAccount,
  }) : super(ProfileState.initial()) {
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

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    final profile = await getUserProfile(NoParams());
    final notifications = await getNotificationSettings(NoParams());
    emit(state.copyWith(profile: profile, notifications: notifications));
  }

  Future<void> _onUpdateName(UpdateName event, Emitter<ProfileState> emit) async {
    final updated = state.profile.copyWith(name: event.name);
    await updateUserProfile(updated);
    emit(state.copyWith(profile: updated));
  }

  Future<void> _onUpdateUsername(UpdateUsername event, Emitter<ProfileState> emit) async {
    final updated = state.profile.copyWith(username: event.username);
    await updateUserProfile(updated);
    emit(state.copyWith(profile: updated));
  }

  Future<void> _onUpdateNotificationSetting(UpdateNotificationSetting event, Emitter<ProfileState> emit) async {
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

    await updateNotificationSettings(updated);
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

  Future<void> _onSignOut(SignOutEvent event, Emitter<ProfileState> emit) async {
    await signOut(NoParams());
    emit(ProfileState.initial());
  }

  Future<void> _onArchiveAccount(ArchiveAccountEvent event, Emitter<ProfileState> emit) async {
    await archiveAccount(NoParams());
  }

  Future<void> _onDeleteAccount(DeleteAccountEvent event, Emitter<ProfileState> emit) async {
    await deleteAccount(NoParams());
  }
}
