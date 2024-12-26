import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Patient {
  String fullname;
  String email;
  String phone;
  String address;
  String? avaUrl;
  List<String>? allergies;
  List<String>? medicalHistory;

  Patient({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.address,
    this.avaUrl,
    this.allergies,
    this.medicalHistory,
  });

  static Future<void> saveProfile(Patient profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = jsonEncode({
      'fullname': profile.fullname,
      'email': profile.email,
      'phone': profile.phone,
      'address': profile.address,
      'avaUrl': profile.avaUrl,
      'allergies': profile.allergies ?? [],
      'medicalHistory': profile.medicalHistory ?? [],
    });
    await prefs.setString('selectedProfile', profileJson);
  }
}