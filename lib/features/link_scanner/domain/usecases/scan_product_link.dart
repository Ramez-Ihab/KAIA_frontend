import 'package:kaia/core/usecases/usecase.dart';
import 'package:kaia/features/link_scanner/domain/entities/scanned_link.dart';
import 'package:kaia/features/link_scanner/domain/repositories/link_scanner_repository.dart';

class ScanProductLink extends UseCase<ScannedLink, String> {
  final LinkScannerRepository repository;

  ScanProductLink(this.repository);

  @override
  Future<ScannedLink> call(String url) {
    return repository.scanLink(url);
  }
}