class Appointment {
  String status;
  int price;
  String date;

  Appointment({required this.status, required this.price, required this.date});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      status: json['appointment_status'],
      price: json['price'],
      date: json['created_at'] as String,
    );
  }
}
