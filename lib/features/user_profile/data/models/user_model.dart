import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifequest/features/user_profile/domain/entities/user.dart';

class UserModel extends UserEntity {
  final DateTime createdAt;
  UserModel({
    required super.uid,
    required super.username,
    required this.createdAt,
    super.level,
    super.health,
    super.experience,
  });

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "createdAt": Timestamp.fromDate(createdAt),
      "level": level,
      "health": health,
      "experience": experience,
    };
  }

  /// Convert from Firestore JSON
  factory UserModel.fromJson(String uid, Map<String, dynamic> json) {
    return UserModel(
      uid: uid,
      username: json["username"] ?? "",
      createdAt: (json["createdAt"] as Timestamp).toDate(),
      level: json["level"] ?? 1,
      health: json["health"] ?? 100,
      experience: json["experience"] ?? 0,
    );
  }
}
