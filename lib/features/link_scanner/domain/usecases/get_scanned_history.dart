import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/link_scanner/domain/entities/scanned_link.dart';
import 'package:kaia/features/link_scanner/domain/repositories/link_scanner_repository.dart';

class GetScannedHistory extends UseCase<List<ScannedLink>, NoParams> {
  final LinkScannerRepository repository;

  GetScannedHistory(this.repository);

  @override
  Future<List<ScannedLink>> call(NoParams params) {
    return repository.getScannedHistory();
  }
}