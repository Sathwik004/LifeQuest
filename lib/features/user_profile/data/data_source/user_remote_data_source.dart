import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifequest/core/exceptions/server_exception.dart';
import 'package:lifequest/features/user_profile/data/models/user_model.dart';

abstract interface class UserRemoteDataSource {
  Future<bool> doesUserExist(String userId);
  Future<void> createUser(UserModel user);
  Future<UserModel> getUser(String userId);
  Future<void> addExperience(String userId, int experience);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addExperience(String userId, int experience) async {
    try {
      final userRef = firestore.collection('users').doc(userId);

      await userRef.update({
        'experience': FieldValue.increment(experience),
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> doesUserExist(String userId) async {
    try {
      final user = await firestore.collection('users').doc(userId).get();
      return user.exists;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await firestore.collection("users").doc(user.uid).set(user.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final userDoc = await firestore.collection("users").doc(userId).get();
    return UserModel.fromJson(userId, userDoc.data()!);
  }
}
