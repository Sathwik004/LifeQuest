import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/auth/domain/repo/auth_repo.dart';

class UserSignIn implements UseCase<String, NoParams> {
  final AuthRepo authRepo;

  UserSignIn({required this.authRepo});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepo.signInWithGoogle();
  }
}
