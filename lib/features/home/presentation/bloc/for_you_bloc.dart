import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/home/domain/usecases/get_for_you_feed.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_event.dart';
import 'package:kaia/features/home/presentation/bloc/for_you_state.dart';

class ForYouBloc extends Bloc<ForYouEvent, ForYouState> {
  final GetForYouFeed getForYouFeed;

  ForYouBloc({required this.getForYouFeed}) : super(ForYouState.initial()) {
    on<LoadForYouFeed>(_onLoadForYouFeed);
  }

  Future<void> _onLoadForYouFeed(LoadForYouFeed event, Emitter<ForYouState> emit) async {
    final sections = await getForYouFeed(NoParams());
    emit(state.copyWith(sections: sections));
  }
}
