import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _supabase.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<AuthResponse> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _supabase.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: 'myapp://create-profile',
      );
    } on AuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      return await _supabase.auth
          .resetPasswordForEmail(email, redirectTo: 'myapp://reset-password');
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  Future<void> updatePassword({required String password}) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(password: password));
    } catch (e) {
      throw Exception('Failed to update password: $e');
    }
  }

  String? getCurruentUserEmail() {
    try {
      final session = _supabase.auth.currentSession;
      final user = session?.user;
      return user?.email;
    } catch (e) {
      throw (Exception('Failed to get current user email: $e'));
    }
  }
}
