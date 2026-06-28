import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/constants/kaia_colors.dart';
import 'package:kaia/features/profile/presentation/bloc/preferences_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/preferences_event.dart';
import 'package:kaia/features/profile/presentation/bloc/preferences_state.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_event.dart';
import 'package:kaia/features/profile/presentation/bloc/profile_state.dart';

void showPreferencesBottomSheet({required BuildContext context}) {
  // Seed the draft with whatever is currently saved in ProfileBloc
  final currentPreferences = context.read<ProfileBloc>().state.preferences;
  context.read<PreferencesBloc>().add(LoadPreferences(currentPreferences));

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<PreferencesBloc>()),
        BlocProvider.value(value: context.read<ProfileBloc>()),
      ],
      child: const _PreferencesBottomSheet(),
    ),
  );
}

class _PreferencesBottomSheet extends StatelessWidget {
  const _PreferencesBottomSheet();

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

  void _onSave(BuildContext context, PreferencesState draft) {
    context.read<ProfileBloc>().add(UpdateContentPreferences(draft.contentPreferences.toList()));
    context.read<ProfileBloc>().add(UpdateSizes(draft.sizes.toList()));
    context.read<ProfileBloc>().add(UpdateShoeSizes(draft.shoeSizes.toList()));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
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
                        context: context,
                        options: _contentOptions,
                        selected: state.contentPreferences,
                        circular: false,
                        onToggle: (v) => context.read<PreferencesBloc>().add(ToggleContentPreference(v)),
                      ),
                      const SizedBox(height: 20),
                      _buildSectionLabel('SIZES'),
                      const SizedBox(height: 10),
                      _buildChipWrap(
                        context: context,
                        options: _sizeOptions,
                        selected: state.sizes,
                        circular: true,
                        onToggle: (v) => context.read<PreferencesBloc>().add(ToggleSize(v)),
                      ),
                      const SizedBox(height: 20),
                      _buildSectionLabel('SHOE SIZE (EU)'),
                      const SizedBox(height: 10),
                      _buildChipWrap(
                        context: context,
                        options: _shoeSizeOptions,
                        selected: state.shoeSizes,
                        circular: true,
                        onToggle: (v) => context.read<PreferencesBloc>().add(ToggleShoeSize(v)),
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
                    onTap: () => _onSave(context, state),
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
    required BuildContext context,
    required List<String> options,
    required Set<String> selected,
    required bool circular,
    required ValueChanged<String> onToggle,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selected.contains(option);
        return GestureDetector(
          onTap: () => onToggle(option),
          child: Container(
            padding: circular
                ? const EdgeInsets.all(12)
                : const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              shape: circular ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: circular ? null : BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? Colors.black : darkgreyColor.withValues(alpha: 0.35),
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
