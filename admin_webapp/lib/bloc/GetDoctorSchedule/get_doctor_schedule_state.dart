part of 'get_doctor_schedule_bloc.dart';

sealed class GetDoctorScheduleState extends Equatable {
  const GetDoctorScheduleState();
  
  @override
  List<Object> get props => [];
}

final class GetDoctorScheduleInitial extends GetDoctorScheduleState {}

final class GetDoctorScheduleLoading extends GetDoctorScheduleState {}

final class GetDoctorScheduleSuccess extends GetDoctorScheduleState {
  // final List<Map<String, dynamic>> doctorSchedule;
  final List<DoctorSchedule> scheduleList;
  const GetDoctorScheduleSuccess({required this.scheduleList});

  @override
  List<Object> get props => [scheduleList];
}

final class GetDoctorScheduleFailure extends GetDoctorScheduleState {
  final String error;

  const GetDoctorScheduleFailure({required this.error});

  @override
  List<Object> get props => [error];
}