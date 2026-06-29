import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/features/profile/presentation/bloc/currency_event.dart';
import 'package:kaia/features/profile/presentation/bloc/currency_state.dart';
import 'package:kaia/features/profile/presentation/widgets/currency_bottom_sheet.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyState.initial()) {
    on<SetCurrency>(_onSetCurrency);
  }

  void _onSetCurrency(SetCurrency event, Emitter<CurrencyState> emit) {
    final option = allCurrencies.firstWhere(
      (c) => c.code == event.code,
      orElse: () => state.selected,
    );
    emit(state.copyWith(selected: option));
  }
}
