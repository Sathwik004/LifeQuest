import 'package:equatable/equatable.dart';

class Groups extends Equatable {
  final String id;
  final String name;
  final String description;
  final String creatorId;
  final List<String> memberIds;
  final String badgeColor;
  final DateTime createdAt;
  final List<Map<String, dynamic>> habits;

  const Groups({
    required this.id,
    required this.name,
    required this.description,
    required this.creatorId,
    required this.memberIds,
    required this.badgeColor,
    required this.createdAt,
    required this.habits,
  });

  Groups copyWith({
    String? id,
    String? name,
    String? description,
    String? creatorId,
    List<String>? memberIds,
    String? badgeColor,
    DateTime? createdAt,
    List<Map<String, dynamic>>? habits,
  }) {
    return Groups(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      creatorId: creatorId ?? this.creatorId,
      memberIds: memberIds ?? this.memberIds,
      badgeColor: badgeColor ?? this.badgeColor,
      createdAt: createdAt ?? this.createdAt,
      habits: habits ?? this.habits,
    );
  }

  @override
  get props => [
        id,
        name,
        description,
        creatorId,
        memberIds,
        badgeColor,
        createdAt,
        habits
      ];
}
