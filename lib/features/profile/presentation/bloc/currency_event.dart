abstract class CurrencyEvent {}

class SetCurrency extends CurrencyEvent {
  final String code;
  SetCurrency(this.code);
}
