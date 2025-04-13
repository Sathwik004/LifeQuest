import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifequest/core/exceptions/server_exception.dart';
import 'package:lifequest/features/groups/data/models/group_model.dart';

abstract interface class GroupRemoteDataSource {
  Future<void> createGroup(GroupModel group);
  Future<void> joinGroup(String groupId, String userId);
  Future<void> leaveGroup(String groupId, String userId);
  Future<List<GroupModel>> getGroupsForUser(String userId);
  Future<List<GroupModel>> discoverGroups({int limit = 20});
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final FirebaseFirestore firestore;

  GroupRemoteDataSourceImpl(this.firestore);
  @override
  Future<void> createGroup(GroupModel group) async {
    try {
      await firestore.collection('groups').doc(group.id).set(group.toMap());
    } catch (e) {
      throw ServerException('Failed to create group: $e');
    }
  }

  @override
  Future<void> joinGroup(String groupId, String userId) async {
    try {
      final docRef = firestore.collection('groups').doc(groupId);
      final doc = await docRef.get();

      if (!doc.exists) throw Exception('Group does not exist');

      final data = doc.data();
      if (data == null) throw Exception('Invalid group data');

      final currentMembers = List<String>.from(data['memberIds'] ?? []);

      if (currentMembers.contains(userId)) return;

      if (currentMembers.length >= 20) {
        throw Exception('Group is full');
      }

      await docRef.update({
        'memberIds': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      throw ServerException('Failed to join group: $e');
    }
  }

  @override
  Future<void> leaveGroup(String groupId, String userId) async {
    try {
      final docRef = firestore.collection('groups').doc(groupId);

      // Step 1: Remove the user from the memberIds array
      await docRef.update({
        'memberIds': FieldValue.arrayRemove([userId]),
      });

      // Step 2: Re-fetch the updated group document
      final updatedDoc = await docRef.get();

      if (updatedDoc.exists) {
        final data = updatedDoc.data();
        final members = List<String>.from(data?['memberIds'] ?? []);

        // Step 3: Delete the group if there are no members left
        if (members.isEmpty) {
          await docRef.delete();
        }
      }
    } catch (e) {
      throw ServerException('Failed to leave group: $e');
    }
  }

  @override
  Future<List<GroupModel>> getGroupsForUser(String userId) async {
    try {
      final snapshot = await firestore
          .collection('groups')
          .where('memberIds', arrayContains: userId)
          .get();

      return snapshot.docs
          .map((doc) => GroupModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException('Failed to fetch user groups: $e');
    }
  }

  @override
  Future<List<GroupModel>> discoverGroups({int limit = 20}) async {
    try {
      final snapshot = await firestore
          .collection('groups')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => GroupModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException('Failed to discover groups: $e');
    }
  }
}
