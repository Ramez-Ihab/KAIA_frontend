// lib/features/profile/domain/entities/notification_settings.dart

class NotificationSettings {
  final bool masterToggle;
  final bool priceDrops;
  final bool backInStock;
  final bool newArrivals;
  final bool newCollections;
  final bool saleAlerts;

  const NotificationSettings({
    required this.masterToggle,
    required this.priceDrops,
    required this.backInStock,
    required this.newArrivals,
    required this.newCollections,
    required this.saleAlerts,
  });

  NotificationSettings copyWith({
    bool? masterToggle,
    bool? priceDrops,
    bool? backInStock,
    bool? newArrivals,
    bool? newCollections,
    bool? saleAlerts,
  }) {
    return NotificationSettings(
      masterToggle: masterToggle ?? this.masterToggle,
      priceDrops: priceDrops ?? this.priceDrops,
      backInStock: backInStock ?? this.backInStock,
      newArrivals: newArrivals ?? this.newArrivals,
      newCollections: newCollections ?? this.newCollections,
      saleAlerts: saleAlerts ?? this.saleAlerts,
    );
  }
}