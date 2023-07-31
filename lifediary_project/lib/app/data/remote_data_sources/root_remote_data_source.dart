import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';



@injectable
class RootRemoteDataSource {
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

}
