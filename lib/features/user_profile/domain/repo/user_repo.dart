import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/features/user_profile/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Either<Failure, bool>> doesUserExist(String userId);
  Future<Either<Failure, void>> saveUser(UserEntity user);
  Future<Either<Failure, UserEntity>> getUser(String userId);
  Future<Either<Failure, void>> addExperience(String userId, int experience);
}
