import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/usecase/usecase.dart';
import 'package:lifequest/features/auth/domain/repo/auth_repo.dart';

class UserSignOut implements UseCase<void, NoParams> {
  final AuthRepo authRepo;

  UserSignOut({required this.authRepo});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepo.signOut();
  }
}
