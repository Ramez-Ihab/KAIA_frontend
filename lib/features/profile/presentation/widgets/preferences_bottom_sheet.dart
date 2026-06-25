import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

void showPreferencesBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const _PreferencesBottomSheet(),
  );
}

class _PreferencesBottomSheet extends StatefulWidget {
  const _PreferencesBottomSheet();

  @override
  State<_PreferencesBottomSheet> createState() =>
      _PreferencesBottomSheetState();
}

class _PreferencesBottomSheetState extends State<_PreferencesBottomSheet> {
  // TODO: persist via domain/data layer
  final Set<String> _selectedContent = {};
  final Set<String> _selectedSizes = {};
  final Set<String> _selectedShoeSizes = {};

  static const _contentOptions = [
    "Women's Fashion",
    "Men's Fashion",
    "Kid's Fashion",
    'Home Accessories',
  ];

  static const _sizeOptions = ['XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL'];

  static const _shoeSizeOptions = [
    '35', '36', '37', '38', '39', '40', '41',
    '42', '43', '44', '45', '46', '47',
  ];

  void _onSave() {
    // TODO: wire to save preferences domain use case
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) {
        return Column(
          children: [
            // Drag handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: darkgreyColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Title row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  const Text(
                    'Preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'GlacialIndifference',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, size: 22, color: darkgreyColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Scrollable content
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                children: [
                  _buildSectionLabel('CONTENT PREFERENCES'),
                  const SizedBox(height: 10),
                  _buildChipWrap(
                    options: _contentOptions,
                    selected: _selectedContent,
                    circular: false,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionLabel('SIZES'),
                  const SizedBox(height: 10),
                  _buildChipWrap(
                    options: _sizeOptions,
                    selected: _selectedSizes,
                    circular: true,
                  ),
                  const SizedBox(height: 20),
                  _buildSectionLabel('SHOE SIZE (EU)'),
                  const SizedBox(height: 10),
                  _buildChipWrap(
                    options: _shoeSizeOptions,
                    selected: _selectedShoeSizes,
                    circular: true,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            // Save button
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                0,
                20,
                24 + MediaQuery.of(context).padding.bottom,
              ),
              child: GestureDetector(
                onTap: _onSave,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Save preferences',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GlacialIndifference',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'GlacialIndifference',
        fontWeight: FontWeight.w700,
        color: darkgreyColor,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildChipWrap({
    required List<String> options,
    required Set<String> selected,
    required bool circular,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selected.contains(option);
        return GestureDetector(
          onTap: () => setState(() {
            if (isSelected) {
              selected.remove(option);
            } else {
              selected.add(option);
            }
          }),
          child: Container(
            padding: circular
                ? const EdgeInsets.all(12)
                : const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              shape: circular ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: circular ? null : BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? Colors.black
                    : darkgreyColor.withValues(alpha: 0.35),
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'GlacialIndifference',
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
