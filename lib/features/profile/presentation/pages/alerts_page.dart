import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_event.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_state.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final n = state.notifications;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const Divider(height: 1, thickness: 0.5),
                  const SizedBox(height: 16),
                  _buildMasterToggle(context, n.masterToggle),
                  const SizedBox(height: 20),
                  _buildSectionLabel('WHAT TO NOTIFY ME ABOUT'),
                  _buildToggleRow(
                    context: context,
                    label: 'Price drops',
                    subtitle: 'When a saved item goes on sale',
                    value: n.priceDrops,
                    setting: 'priceDrops',
                  ),
                  _buildToggleRow(
                    context: context,
                    label: 'Back in stock',
                    subtitle: 'When a sold-out item returns',
                    value: n.backInStock,
                    setting: 'backInStock',
                  ),
                  _buildToggleRow(
                    context: context,
                    label: 'New arrivals',
                    subtitle: 'From the brands you favourite',
                    value: n.newArrivals,
                    setting: 'newArrivals',
                  ),
                  _buildToggleRow(
                    context: context,
                    label: 'New collections & drops',
                    subtitle: 'Fresh launches as they happen',
                    value: n.newCollections,
                    setting: 'newCollections',
                  ),
                  _buildToggleRow(
                    context: context,
                    label: 'Sale alerts',
                    subtitle: 'Major sales and seasonal events',
                    value: n.saleAlerts,
                    setting: 'saleAlerts',
                  ),
                  _buildToggleRow(
                    context: context,
                    label: 'Order & shipping',
                    subtitle: 'Updates on items you\'ve ordered',
                    value: n.orderShipping,
                    setting: 'orderShipping',
                  ),
                  _buildToggleRow(
                    context: context,
                    label: 'Recommendations',
                    subtitle: 'Picks chosen for your style',
                    value: n.recommendations,
                    setting: 'recommendations',
                  ),
                  const SizedBox(height: 20),
                  _buildSectionLabel('HOW TO NOTIFY ME'),
                  _buildToggleRow(
                    context: context,
                    label: 'Push notifications',
                    subtitle: 'On this device',
                    value: n.pushNotifications,
                    setting: 'pushNotifications',
                  ),
                  _buildToggleRow(
                    context: context,
                    label: 'Email',
                    subtitle: 'Weekly digest of activity',
                    value: n.email,
                    setting: 'email',
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'You can change these any time. We\'ll only notify you about things you\'ve turned on.',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'GlacialIndifference',
                        color: darkgreyColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, size: 22),
          ),
          const SizedBox(width: 16),
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'GlacialIndifference',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMasterToggle(BuildContext context, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primaryColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.1),
              ),
              child: Icon(Icons.notifications_outlined, size: 20, color: primaryColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Allow notifications',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GlacialIndifference',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Stay in the loop on drops, deals, and the brands you love',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'GlacialIndifference',
                      color: darkgreyColor,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: (v) => context.read<ProfileBloc>().add(
                    UpdateNotificationSetting(setting: 'masterToggle', value: v),
                  ),
              activeThumbColor: Colors.white,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: darkgreyColor.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'GlacialIndifference',
          fontWeight: FontWeight.w700,
          color: darkgreyColor,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildToggleRow({
    required BuildContext context,
    required String label,
    required String subtitle,
    required bool value,
    required String setting,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: darkgreyColor.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'GlacialIndifference',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'GlacialIndifference',
                    color: darkgreyColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (v) => context.read<ProfileBloc>().add(
                  UpdateNotificationSetting(setting: setting, value: v),
                ),
            activeThumbColor: Colors.white,
            activeTrackColor: Colors.green,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: darkgreyColor.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
