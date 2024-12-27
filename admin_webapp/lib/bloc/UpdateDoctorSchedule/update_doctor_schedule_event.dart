part of 'update_doctor_schedule_bloc.dart';

sealed class UpdateDoctorScheduleEvent extends Equatable {
  const UpdateDoctorScheduleEvent();

  @override
  List<Object> get props => [];
}

class UpdateDoctorScheduleRequired extends UpdateDoctorScheduleEvent {
  final String doctorID;
  final List<Map<String, dynamic>> timeSlotJson;

  const UpdateDoctorScheduleRequired({
    required this.doctorID,
    required this.timeSlotJson,
  });

  @override
  List<Object> get props => [doctorID, timeSlotJson];
}
