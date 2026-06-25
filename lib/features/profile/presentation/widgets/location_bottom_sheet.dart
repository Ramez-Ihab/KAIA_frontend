import 'package:flutter/material.dart';
import 'package:kaia/core/constants/country.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

void showLocationBottomSheet({
  required BuildContext context,
  required Country selectedCountry,
  required ValueChanged<Country> onSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _LocationBottomSheet(
      selectedCountry: selectedCountry,
      onSelected: onSelected,
    ),
  );
}

class _LocationBottomSheet extends StatelessWidget {
  final Country selectedCountry;
  final ValueChanged<Country> onSelected;

  const _LocationBottomSheet({
    required this.selectedCountry,
    required this.onSelected,
  });

  static const _countries = [
    Country.egypt,
    Country.saudiArabia,
    Country.uae,
    Country.lebanon,
    Country.jordan,
    Country.kuwait,
    Country.qatar,
    Country.bahrain,
    Country.oman,
    Country.palestine,
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.92,
      expand: false,
      builder: (_, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Your location',
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Set your location so we can recommend brands that ship to you or are local to your country.',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'GlacialIndifference',
                  color: darkgreyColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _countries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final country = _countries[index];
                  final isSelected = country == selectedCountry;
                  return GestureDetector(
                    onTap: () {
                      onSelected(country);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.black
                            : greyColor.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            country.isoCode,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'GlacialIndifference',
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            country.label,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'GlacialIndifference',
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            country.displayCode,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GlacialIndifference',
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.7)
                                  : darkgreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
