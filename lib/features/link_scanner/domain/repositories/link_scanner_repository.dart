import 'package:kaia/features/link_scanner/domain/entities/scanned_link.dart';
abstract class LinkScannerRepository {
  Future<ScannedLink> scanLink(String url);
  Future<List<ScannedLink>> getScannedHistory();
}