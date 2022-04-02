import 'package:firebase_auth/firebase_auth.dart';
import 'package:global_conference/models/app_user.dart';
import 'package:global_conference/utils/cache_client.dart';

class LoginWithEmailAndPasswordFailure implements Exception {
  const LoginWithEmailAndPasswordFailure(
      [this.message = 'An Unknown error as occured']);

  factory LoginWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LoginWithEmailAndPasswordFailure(
            'Email address is not valid');
      case 'user-disabled':
        return const LoginWithEmailAndPasswordFailure(
            'This user has been disabled, please contact the conference organisers');
      case 'user-not-found':
        return const LoginWithEmailAndPasswordFailure(
            'Email address not registered');
      case 'wrong-password':
        return const LoginWithEmailAndPasswordFailure('Incorrect password');
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cache,
    FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final CacheClient _cache;
  final FirebaseAuth _firebaseAuth;

  static const userCacheKey = '__user_cache_key__';

  Stream<AppUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user =
          firebaseUser == null ? AppUser.empty : firebaseUser.toAppUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  AppUser get currentUser {
    return _cache.read<AppUser>(key: userCacheKey) ?? AppUser.empty;
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw LoginWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LoginWithEmailAndPasswordFailure();
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}

extension on User {
  AppUser get toAppUser => AppUser(uid: uid, email: email);
}
