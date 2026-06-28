import 'package:kaia/core/entities/look.dart';
import 'package:kaia/features/home/domain/entities/feed_section.dart';
import 'package:kaia/features/home/domain/entities/featured_item.dart';
import 'package:kaia/features/home/domain/entities/mood_item.dart';

abstract class HomeRepository {
  Future<List<FeedSection>> getForYouFeed();
  Future<FeaturedItem> getFeaturedItem();
  Future<List<MoodItem>> getMoodItems();
  Future<List<Look>> getTrendingLooks();
  Future<List<Look>> getArrivalLooks();
}
