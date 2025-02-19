import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifequest/core/exceptions/server_exception.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signInWithGoogle();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth; //Firebase.instance
  final GoogleSignIn googleSignIn; //GoogleSignIn()

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.googleSignIn});
  @override
  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredentials =
          await firebaseAuth.signInWithCredential(credential);

      return userCredentials.user!.uid;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
