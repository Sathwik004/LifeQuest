import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/exceptions/server_exception.dart';
import 'package:lifequest/features/user_profile/data/data_source/user_remote_data_source.dart';
import 'package:lifequest/features/user_profile/data/models/user_model.dart';
import 'package:lifequest/features/user_profile/domain/entities/user.dart';
import 'package:lifequest/features/user_profile/domain/repo/user_repo.dart';

class UserRepoImpl implements UserRepository {
  final UserRemoteDataSource userDataSource;

  UserRepoImpl({required this.userDataSource});

  @override
  Future<Either<Failure, void>> addExperience(
      String userId, int experience) async {
    try {
      await userDataSource.addExperience(userId, experience);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> doesUserExist(String userId) async {
    try {
      final exists = await userDataSource.doesUserExist(userId);
      return right(exists);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String userId) async {
    try {
      final userModel = await userDataSource.getUser(userId);
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(UserEntity user) async {
    try {
      final userModel = UserModel(
        uid: user.uid,
        username: user.username,
        createdAt: DateTime.now(),
        level: user.level,
        experience: user.experience,
        health: user.health,
      );
      await userDataSource.createUser(userModel);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
