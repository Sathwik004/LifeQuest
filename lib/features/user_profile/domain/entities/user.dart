class UserEntity {
  final String uid;
  final String username;
  final int level;
  final int health;
  final int experience;

  const UserEntity({
    required this.uid,
    required this.username,
    this.level = 1,
    this.health = 100,
    this.experience = 0,
  });

  UserEntity copyWith({
    String? uid,
    String? username,
    int? level,
    int? health,
    int? experience,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      level: level ?? this.level,
      health: health ?? this.health,
      experience: experience ?? this.experience,
    );
  }
}
