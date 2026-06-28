// lib/features/profile/presentation/bloc/profile_event.dart

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateName extends ProfileEvent {
  final String name;
  UpdateName(this.name);
}

class UpdateUsername extends ProfileEvent {
  final String username;
  UpdateUsername(this.username);
}

class UpdateNotificationSetting extends ProfileEvent {
  final String setting;
  final bool value;
  UpdateNotificationSetting({required this.setting, required this.value});
}

class UpdateContentPreferences extends ProfileEvent {
  final List<String> preferences;
  UpdateContentPreferences(this.preferences);
}

class UpdateSizes extends ProfileEvent {
  final List<String> sizes;
  UpdateSizes(this.sizes);
}

class UpdateShoeSizes extends ProfileEvent {
  final List<String> shoeSizes;
  UpdateShoeSizes(this.shoeSizes);
}

class SignOutEvent extends ProfileEvent {}

class ArchiveAccountEvent extends ProfileEvent {}

class DeleteAccountEvent extends ProfileEvent {}