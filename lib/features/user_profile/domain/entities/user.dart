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
}
