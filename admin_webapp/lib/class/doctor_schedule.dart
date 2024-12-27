class DoctorSchedule {
  final String timeslotId;
  final bool timeslotStatus;
  final DateTime timeslotDate;
  final String timeslotTime;

  DoctorSchedule({
    required this.timeslotId,
    required this.timeslotStatus,
    required this.timeslotDate,
    required this.timeslotTime,
  });

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) {
    return DoctorSchedule(
      timeslotId: json['timeslot_id'],
      timeslotStatus: json['timeslot_status'],
      timeslotDate: DateTime.parse(json['timeslot_date']),
      timeslotTime: json['timeslot_time'],
    );
  }

  @override
  String toString() {
    return 'DoctorSchedule(timeslotId: $timeslotId, timeslotStatus: $timeslotStatus, timeslotDate: $timeslotDate, timeslotTime: $timeslotTime)';
  }
}
