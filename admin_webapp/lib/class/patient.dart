class Patient {
  final String fullname;
  final String email;
  final String phone;
  final String address;
  final String dob;
  String? avaUrl;
  List<String>? allergies;
  List<String>? medicalHistory;

  Patient({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.address,
    required this.dob,
    this.avaUrl,
    this.allergies,
    this.medicalHistory,
  });
}