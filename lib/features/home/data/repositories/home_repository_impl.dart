import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/data/datasources/home_local_data_source.dart';
import 'package:kaia/features/home/domain/entities/feed_section.dart';
import 'package:kaia/features/home/domain/entities/featured_item.dart';
import 'package:kaia/features/home/domain/entities/mood_item.dart';
import 'package:kaia/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<List<FeedSection>> getForYouFeed() => dataSource.getForYouFeed();

  @override
  Future<FeaturedItem> getFeaturedItem() => dataSource.getFeaturedItem();

  @override
  Future<List<MoodItem>> getMoodItems() => dataSource.getMoodItems();

  @override
  Future<List<Look>> getTrendingLooks() => dataSource.getTrendingLooks();

  @override
  Future<List<Look>> getArrivalLooks() => dataSource.getArrivalLooks();
}
