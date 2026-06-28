import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/home/domain/entities/mood_item.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class GetMoodItems extends UseCase<List<MoodItem>, NoParams> {
  final HomeRepository repository;

  GetMoodItems(this.repository);

  @override
  Future<List<MoodItem>> call(NoParams params) {
    return repository.getMoodItems();
  }
}
