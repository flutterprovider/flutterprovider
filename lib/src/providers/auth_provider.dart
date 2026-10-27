import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase/firebase_auth_service.dart';
import '../shared_prefs/prefs_service.dart';
import '../shared_prefs/prefs_keys.dart';
import '../utils/logger_utils.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;

  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  final FirebaseAuthService _authService = FirebaseAuthService.instance;

  AuthProvider() {
    _listenAuthState();
  }

  void _listenAuthState() {
    _authService.authStateChanges.listen((user) {
      _user = user;
      _status = user != null
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated;
      notifyListeners();
      AppLogger.info('Auth state changed: ${user?.email}');
    });
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading();
    try {
      final result = await _authService.signInWithEmail(
        email: email,
        password: password,
      );
      if (result != null) {
        await PrefsService.instance.setBool(PrefsKeys.isLoggedIn, true);
        await PrefsService.instance.setString(
            PrefsKeys.userEmail, email);
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    _setLoading();
    try {
      final result = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );
      if (result != null) {
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    await PrefsService.instance.setBool(PrefsKeys.isLoggedIn, false);
    _status = AuthStatus.unauthenticated;
    _user = null;
    notifyListeners();
  }

  Future<bool> sendPasswordReset(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
