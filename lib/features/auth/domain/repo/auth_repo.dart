import 'package:fpdart/fpdart.dart';
import 'package:lifequest/core/errors/failure.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, String>> signInWithGoogle();
  Future<Either<Failure, void>> signOut();
}
