class UserProfile{
  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final int savedCount;
  final int brandsCount;
  final int categoriesCount;

  const UserProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.savedCount,
    required this.brandsCount,
    required this.categoriesCount,

    
});

UserProfile copyWith({
  String? name,
  String? username,
  String? avatarUrl,
}) {
  return UserProfile(
    id: id,
    name: name ?? this.name,
    username: username ?? this.username,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    savedCount: savedCount,
    brandsCount: brandsCount,
    categoriesCount: categoriesCount,
  );
}
  
}