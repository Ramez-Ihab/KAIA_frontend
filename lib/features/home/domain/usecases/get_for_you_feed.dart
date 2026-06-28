import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/home/domain/entities/feed_section.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class GetForYouFeed extends UseCase<List<FeedSection>, NoParams> {
  final HomeRepository repository;

  GetForYouFeed(this.repository);

  @override
  Future<List<FeedSection>> call(NoParams params) {
    return repository.getForYouFeed();
  }
}
