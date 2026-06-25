
import 'package:kaia/features/saved/domain/usecases/saved_category.dart';
import 'package:kaia/core/entities/look.dart';

class SavedItem {
  final Look look;
  final SavedCategory? category;
  final DateTime savedDate;

  const SavedItem({
    required this.look,
    this.category,
    required this.savedDate,
  });

  SavedItem copyWith({SavedCategory? category}) {
    return SavedItem(
      look: look,
      savedDate: savedDate,
      category: category,
    );
  }
}