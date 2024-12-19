import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:html' as html;

class DoctorAuthServices {
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

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      final String currentOrigin = html.window.location.origin;
      // print("currentOrigin: $currentOrigin");
      final String redirectTo = '$currentOrigin/reset-password';
      // print(redirectTo);
      await Supabase.instance.client.auth.resetPasswordForEmail(email, redirectTo: redirectTo);

    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  Future<AuthResponse> verifyOtp(
      {required String email, required String otp}) async {
    try {
      return await _supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.recovery,
      );
    } on AuthException catch (e) {
      throw Exception('Error verifying OTP: ${e.message}');
    }
  }

  Future<void> updatePassword({required String password}) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(password: password));
    } on AuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update password: $e');
    }
  }
}