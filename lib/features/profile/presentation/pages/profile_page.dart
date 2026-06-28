import 'package:flutter/material.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/features/profile/presentation/pages/alerts_page.dart';
import 'package:kaia/features/profile/presentation/pages/archive_account_page.dart';
import 'package:kaia/features/profile/presentation/pages/change_email_page.dart';
import 'package:kaia/features/profile/presentation/pages/delete_account_page.dart';
import 'package:kaia/features/profile/presentation/pages/change_password_page.dart';
import 'package:kaia/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:kaia/features/profile/presentation/pages/favourite_brands_page.dart';
import 'package:kaia/features/profile/presentation/pages/link_history_page.dart';
import 'package:kaia/features/profile/presentation/widgets/currency_bottom_sheet.dart';
import 'package:kaia/features/profile/presentation/widgets/location_bottom_sheet.dart';
import 'package:kaia/features/profile/presentation/widgets/preferences_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_bloc.dart';
import 'package:kaia/features/location/presentation/bloc/location_event.dart';
import 'package:kaia/features/location/presentation/bloc/location_state.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_event.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_state.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:kaia/features/saved/presentation/bloc/saved_state.dart';
import 'package:kaia/features/home/presentation/bloc/brands_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/brands_state.dart';
import 'package:kaia/features/home/presentation/bloc/home_bloc.dart';
import 'package:kaia/features/home/presentation/bloc/home_event.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align elements to the left
        children: [
          
Image.asset(
              'assets/images/KAIA.png',
              width: 200, 
              height: 48, 
              alignment: Alignment.topLeft,
            ),
          
          Expanded(child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Profile picture + name + username + edit button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: darkgreyColor.withValues(alpha: 0.2),
                        border: Border.all(
                            color: darkgreyColor.withValues(alpha: 0.1),
                            width: 1),
                      ),
                      child: Icon(Icons.person,
                          size: 35,
                          color: darkgreyColor.withValues(alpha: 0.4)),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.profile.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'GlacialIndifference',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '@${state.profile.username}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'GlacialIndifference',
                            color: darkgreyColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProfilePage(
                                initialName: state.profile.name,
                                initialUsername: state.profile.username,
                                onSaved: (name, username) {
                                  context.read<ProfileBloc>().add(UpdateName(name));
                                  context.read<ProfileBloc>().add(UpdateUsername(username));
                                },
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: darkgreyColor.withValues(alpha: 0.3)),
                            ),
                            child: const Text(
                              'Edit profile',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'GlacialIndifference',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Stats + action cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    BlocBuilder<SavedBloc, SavedState>(
                      builder: (context, savedState) {
                        final savedCount = savedState.allItems.length;
                        final categoryCount = savedState.allItems
                            .where((item) => item.category != null)
                            .map((item) => item.category!)
                            .toSet()
                            .length;
                        return BlocBuilder<BrandsBloc, BrandsState>(
                          builder: (context, brandsState) {
                            final brandsCount = brandsState.allBrands
                                .where((b) => b.isFavorited)
                                .length;
                            return Row(
                              children: [
                                Expanded(child: _buildStat('$savedCount', 'Saved')),
                                const SizedBox(width: 10),
                                Expanded(child: _buildStat('$brandsCount', 'Brands')),
                                const SizedBox(width: 10),
                                Expanded(child: _buildStat('$categoryCount', 'Categories')),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildActionCard(
                          icon: Icons.favorite_outline,
                          label: 'Brands',
                          isSelected: true,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const FavouriteBrandsPage()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildActionCard(
                          icon: Icons.link,
                          label: 'Links',
                          isSelected: false,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LinkHistoryPage()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildActionCard(
                          icon: Icons.notifications_outlined,
                          label: 'Alerts',
                          isSelected: false,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AlertsPage()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // SETTINGS section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'SETTINGS',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'GlacialIndifference',
                    fontWeight: FontWeight.w700,
                    color: darkgreyColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, locationState) {
                  return _buildSettingsRow(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: locationState.selectedCountry?.label ?? 'Not set',
                    onTap: () {
                      showLocationBottomSheet(
                        context: context,
                        selectedCountry:
                            locationState.selectedCountry ?? Country.all,
                        onSelected: (country) {
                          context.read<LocationBloc>().add(SetLocation(country));
                          context.read<HomeBloc>().add(LocationConfirmed());
                        },
                      );
                    },
                  );
                },
              ),
              _buildSettingsRow(
                icon: Icons.language,
                label: 'Currency',
                value: 'USD',
                onTap: () => showCurrencyBottomSheet(
                  context: context,
                  selectedCode: 'USD',
                  onSelected: (currency) {
                    // Currency BLoC will handle this later
                  },
                ),
              ),
              _buildSettingsRow(
                icon: Icons.notifications_none,
                label: 'Notifications',
                value: _getNotificationCount(state),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AlertsPage()),
                ),
              ),
              _buildSettingsRow(
                icon: Icons.tune,
                label: 'Preferences',
                value: '',
                onTap: () => showPreferencesBottomSheet(context: context),
              ),
              const SizedBox(height: 24),

              // ACCOUNT section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'ACCOUNT',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'GlacialIndifference',
                    fontWeight: FontWeight.w700,
                    color: darkgreyColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildSettingsRow(
                icon: Icons.email_outlined,
                label: 'Change email',
                value: 'you@example.com',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChangeEmailPage()),
                ),
              ),
              _buildSettingsRow(
                icon: Icons.lock_outline,
                label: 'Change password',
                value: '',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ChangePasswordPage()),
                ),
              ),
              _buildSettingsRow(
                icon: Icons.logout,
                label: 'Sign out',
                value: '',
                onTap: () => _showSignOutDialog(context),
              ),
              _buildSettingsRow(
                icon: Icons.archive_outlined,
                label: 'Archive account',
                value: 'Take a break',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ArchiveAccountPage()),
                ),
              ),
              _buildDangerRow(
                icon: Icons.delete_outline,
                label: 'Delete account',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const DeleteAccountPage()),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
    ))]);
      },
    );
  }

  String _getNotificationCount(ProfileState state) {
    final count = state.notifications.enabledCount;
    return '$count on';
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: darkgreyColor.withValues(alpha: 0.1),
                ),
                child: Icon(Icons.logout, size: 26, color: darkgreyColor),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sign out?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'GlacialIndifference',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "You'll need to sign in again to access your saved items and preferences.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'GlacialIndifference',
                  color: darkgreyColor,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: greyColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'GlacialIndifference',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(ctx);
                        context.read<ProfileBloc>().add(SignOutEvent());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Sign out',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'GlacialIndifference',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: 'GlacialIndifference',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'GlacialIndifference',
            color: darkgreyColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? secondaryColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? primaryColor.withValues(alpha: 0.3)
                  : darkgreyColor.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? primaryColor : darkgreyColor,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'GlacialIndifference',
                  fontWeight: FontWeight.w600,
                  color: isSelected ? primaryColor : darkgreyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom:
                BorderSide(color: darkgreyColor.withValues(alpha: 0.1)),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: darkgreyColor),
            const SizedBox(width: 14),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'GlacialIndifference',
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (value.isNotEmpty)
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'GlacialIndifference',
                  color: darkgreyColor,
                ),
              ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right,
                size: 20,
                color: darkgreyColor.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom:
                BorderSide(color: darkgreyColor.withValues(alpha: 0.1)),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.red),
            const SizedBox(width: 14),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'GlacialIndifference',
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right,
                size: 20,
                color: darkgreyColor.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}