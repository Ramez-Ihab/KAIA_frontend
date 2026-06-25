import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  // TODO: persist these via domain/data layer
  bool _allowNotifications = true;
  bool _priceDrops = true;
  bool _backInStock = true;
  bool _newArrivals = true;
  bool _newCollections = false;
  bool _saleAlerts = true;
  bool _orderShipping = true;
  bool _recommendations = false;
  bool _pushNotifications = true;
  bool _email = false;

  @override
  Widget build(BuildContext context) {
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
              _buildMasterToggle(),
              const SizedBox(height: 20),
              _buildSectionLabel('WHAT TO NOTIFY ME ABOUT'),
              _buildToggleRow(
                label: 'Price drops',
                subtitle: 'When a saved item goes on sale',
                value: _priceDrops,
                onChanged: (v) => setState(() => _priceDrops = v),
              ),
              _buildToggleRow(
                label: 'Back in stock',
                subtitle: 'When a sold-out item returns',
                value: _backInStock,
                onChanged: (v) => setState(() => _backInStock = v),
              ),
              _buildToggleRow(
                label: 'New arrivals',
                subtitle: 'From the brands you favourite',
                value: _newArrivals,
                onChanged: (v) => setState(() => _newArrivals = v),
              ),
              _buildToggleRow(
                label: 'New collections & drops',
                subtitle: 'Fresh launches as they happen',
                value: _newCollections,
                onChanged: (v) => setState(() => _newCollections = v),
              ),
              _buildToggleRow(
                label: 'Sale alerts',
                subtitle: 'Major sales and seasonal events',
                value: _saleAlerts,
                onChanged: (v) => setState(() => _saleAlerts = v),
              ),
              _buildToggleRow(
                label: 'Order & shipping',
                subtitle: 'Updates on items you\'ve ordered',
                value: _orderShipping,
                onChanged: (v) => setState(() => _orderShipping = v),
              ),
              _buildToggleRow(
                label: 'Recommendations',
                subtitle: 'Picks chosen for your style',
                value: _recommendations,
                onChanged: (v) => setState(() => _recommendations = v),
              ),
              const SizedBox(height: 20),
              _buildSectionLabel('HOW TO NOTIFY ME'),
              _buildToggleRow(
                label: 'Push notifications',
                subtitle: 'On this device',
                value: _pushNotifications,
                onChanged: (v) => setState(() => _pushNotifications = v),
              ),
              _buildToggleRow(
                label: 'Email',
                subtitle: 'Weekly digest of activity',
                value: _email,
                onChanged: (v) => setState(() => _email = v),
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

  Widget _buildMasterToggle() {
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
              value: _allowNotifications,
              onChanged: (v) => setState(() => _allowNotifications = v),
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
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
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
            onChanged: onChanged,
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
