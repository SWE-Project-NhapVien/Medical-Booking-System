class Doctor {
  String doctorID;
  String fullname;
  List<String> specialization;
  String? avaUrl;
  String phoneNumber;

  Doctor({
    required this.doctorID,
    required this.fullname,
    required this.specialization,
    this.avaUrl = '',
    required this.phoneNumber,
  });
}