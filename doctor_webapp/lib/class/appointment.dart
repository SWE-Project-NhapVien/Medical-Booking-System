class Appointment {
  final String appointmentId;
  final String patientFullName;
  final String? patientGender;
  final String? patientDescription;
  final String? patientAvatarURL;
  final String date;
  final String time;

  Appointment({
    required this.appointmentId,
    required this.patientFullName,
    this.patientGender,
    this.patientDescription,
    this.patientAvatarURL,
    required this.date,
    required this.time,
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      appointmentId: map['appointment_id'] as String,
      patientFullName:
          map['patient_first_name'] + map['patient_last_name'] as String,
      patientGender: map['patient_gender'] ?? '',
      patientDescription: map['patient_description'] ?? '',
      patientAvatarURL: map['patient_avatar_url'] ?? '',
      date: map['appointment_date'],
      time: map['appointment_time'],
    );
  }
}
