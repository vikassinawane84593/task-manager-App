import 'package:firebase_auth/firebase_auth.dart';
class AuthService {

   FirebaseAuth auth = FirebaseAuth.instance;
  Future<String?> signup({
     required String email,
     required String password,
  }) async {

    try {

      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {

    try {

      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;
    }
  }

  Future<void> logout() async {

    await auth.signOut();
  }
}