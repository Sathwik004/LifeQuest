import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String id;
  final String name;
  final String description;
  final String creatorId;
  final List<String> memberIds;
  final String badgeColor;
  final DateTime createdAt;
  final List<Map<String, dynamic>> habits; // list of habit templates

  GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.creatorId,
    required this.memberIds,
    required this.badgeColor,
    required this.createdAt,
    required this.habits,
  });

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      creatorId: map['creatorId'],
      memberIds: List<String>.from(map['memberIds']),
      badgeColor: map['badgeColor'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      habits: List<Map<String, dynamic>>.from(map['habits'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'creatorId': creatorId,
      'memberIds': memberIds,
      'badgeColor': badgeColor,
      'createdAt': Timestamp.fromDate(createdAt),
      'habits': habits,
    };
  }
}
