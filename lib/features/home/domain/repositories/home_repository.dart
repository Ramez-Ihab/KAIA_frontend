import 'package:kaia/core/entities/look.dart';
abstract class HomeRepository {
  Future<List<Look>> getForYouFeed();
  Future<List<Look>> getDiscoverFeed();
  Future<Look> getFeaturedLook();
  Future<List<String>> getMoodCategories();
}