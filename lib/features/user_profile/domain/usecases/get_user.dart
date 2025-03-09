import 'package:lifequest/features/user_profile/domain/repo/user_repo.dart';
import 'package:lifequest/features/user_profile/domain/entities/user.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetUser implements UseCase<UserEntity?, GetUserParams> {
  final UserRepository userRepository;

  GetUser({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(GetUserParams params) async {
    return await userRepository.getUser(params.userId);
  }
}

class GetUserParams {
  final String userId;

  GetUserParams({required this.userId});
}
