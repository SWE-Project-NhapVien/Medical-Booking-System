import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PatientProfile {
  String firstName;
  String lastName;
  String phoneNumber;
  String dob;
  String gender;
  String? relationship;
  String? address;
  String? bloodType;
  double? weight;
  double? height;
  List<String>? allergies;
  List<String>? medicalHistory;
  List<String>? emergencyContacts;
  String? avaUrl;

  PatientProfile({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    this.relationship,
    this.address,
    this.bloodType,
    this.weight,
    this.height,
    this.allergies,
    this.medicalHistory,
    this.emergencyContacts,
    this.avaUrl
  });

  static Future<void> saveProfile(PatientProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = jsonEncode({
      'firstName': profile.firstName,
      'lastName': profile.lastName,
      'phoneNumber': profile.phoneNumber,
      'dob': profile.dob,
      'gender': profile.gender,
      'relationship': profile.relationship ?? '',
      'address': profile.address ?? '',
      'bloodType': profile.bloodType ?? '',
      'weight': profile.weight ?? 0.0,
      'height': profile.height ?? 0.0,
      'allergies': profile.allergies ?? [],
      'medicalHistory': profile.medicalHistory ?? [],
      'emergencyContacts': profile.emergencyContacts ?? [],
      'ava_url': profile.avaUrl ?? ''
    });
    await prefs.setString('selectedProfile', profileJson);
  }

  static Future<PatientProfile?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString('selectedProfile');
    if (profileJson == null) return null;
    final Map<String, dynamic> profileMap = jsonDecode(profileJson);
    return PatientProfile(
      firstName: profileMap['firstName'],
      lastName: profileMap['lastName'],
      phoneNumber: profileMap['phoneNumber'],
      dob: profileMap['dob'],
      gender: profileMap['gender'],
      relationship: profileMap['relationship'],
      address: profileMap['address'],
      bloodType: profileMap['bloodType'],
      weight: profileMap['weight'],
      height: profileMap['height'],
      allergies: List<String>.from(profileMap['allergies']),
      medicalHistory: List<String>.from(profileMap['medicalHistory']),
      emergencyContacts: List<String>.from(profileMap['emergencyContacts']),
      avaUrl: profileMap['ava_url']
    );
  }

  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedProfile');
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? dob,
    String? gender,
    String? relationship,
    String? address,
    String? bloodType,
    double? weight,
    double? height,
    String? avaUrl
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString('selectedProfile');
    if (profileJson == null) return;
    final Map<String, dynamic> profileMap = jsonDecode(profileJson);
    final updatedProfile = PatientProfile(
      firstName: firstName ?? profileMap['firstName'],
      lastName: lastName ?? profileMap['lastName'],
      phoneNumber: phoneNumber ?? profileMap['phoneNumber'],
      address: address ?? profileMap['address'] ?? '',
      dob: dob ?? profileMap['dob'],
      relationship: relationship ?? profileMap['relationship'] ?? '',
      gender: gender ?? profileMap['gender'],
      bloodType: bloodType ?? profileMap['bloodType'] ?? '',
      weight: weight ?? profileMap['weight'],
      height: height ?? profileMap['height'],
      avaUrl: avaUrl ?? profileMap['ava_url'],
    );
    await saveProfile(updatedProfile);
  }
}