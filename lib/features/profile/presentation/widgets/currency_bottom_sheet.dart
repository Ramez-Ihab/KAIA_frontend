import 'package:flutter/material.dart';
import 'package:kaia/core/constants/kaia_colors.dart';

class CurrencyOption {
  final String symbol;
  final String name;
  final String code;
  const CurrencyOption(this.symbol, this.name, this.code);
}

const _currencies = [
  CurrencyOption('د.إ', 'UAE Dirham', 'AED'),
  CurrencyOption('ريال', 'Saudi Riyal', 'SAR'),
  CurrencyOption('E£', 'Egyptian Pound', 'EGP'),
  CurrencyOption('د.ك', 'Kuwaiti Dinar', 'KWD'),
  CurrencyOption('ريال', 'Qatari Riyal', 'QAR'),
  CurrencyOption('BD', 'Bahraini Dinar', 'BHD'),
  CurrencyOption('ريال', 'Omani Riyal', 'OMR'),
  CurrencyOption('JD', 'Jordanian Dinar', 'JOD'),
  CurrencyOption('LL', 'Lebanese Pound', 'LBP'),
  CurrencyOption('\$', 'US Dollar', 'USD'),
  CurrencyOption('€', 'Euro', 'EUR'),
  CurrencyOption('£', 'British Pound', 'GBP'),
];

void showCurrencyBottomSheet({
  required BuildContext context,
  required String selectedCode,
  required ValueChanged<CurrencyOption> onSelected,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _CurrencyBottomSheet(
      selectedCode: selectedCode,
      onSelected: onSelected,
    ),
  );
}

class _CurrencyBottomSheet extends StatelessWidget {
  final String selectedCode;
  final ValueChanged<CurrencyOption> onSelected;

  const _CurrencyBottomSheet({
    required this.selectedCode,
    required this.onSelected,
  });

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
                    'Display currency',
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
                'Choose the currency you want prices displayed in, regardless of your location.',
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
                padding: EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  16 + MediaQuery.of(context).padding.bottom,
                ),
                itemCount: _currencies.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final currency = _currencies[index];
                  final isSelected = currency.code == selectedCode;
                  return GestureDetector(
                    onTap: () {
                      onSelected(currency);
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
                          SizedBox(
                            width: 32,
                            child: Text(
                              currency.symbol,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'GlacialIndifference',
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.7)
                                    : darkgreyColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currency.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'GlacialIndifference',
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            currency.code,
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
          ],
        );
      },
    );
  }
}
