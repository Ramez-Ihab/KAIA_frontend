class NotificationSettings {
  final bool masterToggle;
  final bool priceDrops;
  final bool backInStock;
  final bool newArrivals;
  final bool newCollections;
  final bool saleAlerts;
  final bool orderShipping;
  final bool recommendations;
  final bool pushNotifications;
  final bool email;

  const NotificationSettings({
    required this.masterToggle,
    required this.priceDrops,
    required this.backInStock,
    required this.newArrivals,
    required this.newCollections,
    required this.saleAlerts,
    required this.orderShipping,
    required this.recommendations,
    required this.pushNotifications,
    required this.email,
  });

  int get enabledCount {
    if (!masterToggle) return 0;
    return [
      priceDrops,
      backInStock,
      newArrivals,
      newCollections,
      saleAlerts,
      orderShipping,
      recommendations,
    ].where((v) => v).length;
  }

  NotificationSettings copyWith({
    bool? masterToggle,
    bool? priceDrops,
    bool? backInStock,
    bool? newArrivals,
    bool? newCollections,
    bool? saleAlerts,
    bool? orderShipping,
    bool? recommendations,
    bool? pushNotifications,
    bool? email,
  }) {
    return NotificationSettings(
      masterToggle: masterToggle ?? this.masterToggle,
      priceDrops: priceDrops ?? this.priceDrops,
      backInStock: backInStock ?? this.backInStock,
      newArrivals: newArrivals ?? this.newArrivals,
      newCollections: newCollections ?? this.newCollections,
      saleAlerts: saleAlerts ?? this.saleAlerts,
      orderShipping: orderShipping ?? this.orderShipping,
      recommendations: recommendations ?? this.recommendations,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      email: email ?? this.email,
    );
  }
}
