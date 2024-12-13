class Appointment {
  String appointmentId;
  String status;
  int price;
  String date;

  Appointment(
      {required this.status,
      required this.price,
      required this.date,
      required this.appointmentId});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      status: json['appointment_status'],
      price: json['price'],
      date: json['created_at'] as String,
      appointmentId: json['appointment_id'] as String,
    );
  }
}
