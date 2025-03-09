import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/user_profile/domain/repo/user_repo.dart';

class UserExists implements UseCase<bool, UserExistsParams> {
  final UserRepository userRepository;

  UserExists({required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(UserExistsParams params) async {
    return await userRepository.doesUserExist(params.userId);
  }
}

class UserExistsParams {
  final String userId;

  UserExistsParams({required this.userId});
}
