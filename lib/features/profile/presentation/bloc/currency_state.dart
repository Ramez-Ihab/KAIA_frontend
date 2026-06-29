import 'package:kaia/features/profile/presentation/widgets/currency_bottom_sheet.dart';

class CurrencyState {
  final CurrencyOption selected;

  const CurrencyState({required this.selected});

  factory CurrencyState.initial() => const CurrencyState(
        selected: CurrencyOption('\$', 'US Dollar', 'USD'),
      );

  CurrencyState copyWith({CurrencyOption? selected}) =>
      CurrencyState(selected: selected ?? this.selected);
}
