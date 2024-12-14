import 'package:booking_doctor_project/class/medical_result.dart';

class Appointment {
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentId;
  final String doctorFullName;
  final List<String> specializations;
  String? doctorAvatar;
  MedicalResult? result;
  String status; //upcoming - completed - canceled
  String price;
  

  Appointment({
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentId,
    required this.doctorFullName,
    required this.specializations,
    this.doctorAvatar,
    this.result,
    required this.status,
    this.price = '125000',
  });

  void getMedicalResult(String appointmentId) {
    //
  }
}