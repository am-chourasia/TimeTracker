import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// interface for authentication service
abstract class AuthBase {
  User get currentUser;
  Stream<User> authStateChange();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User> authStateChange() => _firebaseAuth.authStateChanges();

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: "ERROR_GOOGLE_USER_MISSING",
          message: "Missing Google Id Token",
        );
      }
    } else {
      throw FirebaseAuthException(
        code: "ERROR_ABORTED_BY_USER",
        message: "Sign In aborted by User",
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
