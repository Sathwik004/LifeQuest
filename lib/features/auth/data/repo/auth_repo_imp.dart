import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';
import 'package:lifequest/core/exceptions/server_exception.dart';
import 'package:lifequest/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:lifequest/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImp({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithGoogle() async {
    try {
      final userId = await authRemoteDataSource.signInWithGoogle();
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Either<Failure, String> checkAuthState() {
    try {
      final userId = authRemoteDataSource.checkAuthState();
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
