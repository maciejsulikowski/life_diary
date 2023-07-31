import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifediary_project/app/data/remote_data_sources/root_remote_data_source.dart';

class RootRepository {
  RootRepository(this.rootRemoteDataSource);

  final RootRemoteDataSource rootRemoteDataSource;

  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    await rootRemoteDataSource.createUserWithEmailAndPassword(email, password);
  }

  Future<void> signIn({required String email, required String password}) async {
    await rootRemoteDataSource.signInWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    await rootRemoteDataSource.signOut();
  }

  Stream<User?> authStateChanges() {
    return rootRemoteDataSource.authStateChanges();
  }
}
