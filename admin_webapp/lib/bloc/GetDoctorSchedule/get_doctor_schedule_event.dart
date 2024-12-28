part of 'get_doctor_schedule_bloc.dart';

sealed class GetDoctorScheduleEvent extends Equatable {
  const GetDoctorScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetDoctorScheduleRequired extends GetDoctorScheduleEvent {
  final String doctorID;

  const GetDoctorScheduleRequired({required this.doctorID});

  @override
  List<Object> get props => [doctorID];
}
