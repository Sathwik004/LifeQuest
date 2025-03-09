import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/user_profile/domain/repo/user_repo.dart';
import 'package:lifequest/features/user_profile/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

class SaveUser implements UseCase<void, SaveUserParams> {
  final UserRepository userRepository;

  SaveUser({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(SaveUserParams params) async {
    return await userRepository.saveUser(params.user);
  }
}

class SaveUserParams {
  final UserEntity user;

  SaveUserParams({required this.user});
}
