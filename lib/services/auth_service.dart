import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String username = email.split('@')[0];
      return UserModel(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Login failed: ${e.message}');
    }
  }

  Future<UserModel> signup(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String username = email.split('@')[0];
      return UserModel(
        uid: userCredential.user!.uid,
        username: username,
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Signup failed: ${e.message}');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return UserModel(
        uid: user.uid,
        username: user.email!.split('@')[0],
        email: user.email!,
      );
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}