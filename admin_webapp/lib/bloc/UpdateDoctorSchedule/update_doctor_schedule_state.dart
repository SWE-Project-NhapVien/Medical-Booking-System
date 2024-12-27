part of 'update_doctor_schedule_bloc.dart';

sealed class UpdateDoctorScheduleState extends Equatable {
  const UpdateDoctorScheduleState();
  
  @override
  List<Object> get props => [];
}

final class UpdateDoctorScheduleInitial extends UpdateDoctorScheduleState {}

final class UpdateDoctorScheduleLoading extends UpdateDoctorScheduleState {}

final class UpdateDoctorScheduleSuccess extends UpdateDoctorScheduleState {}

final class UpdateDoctorScheduleFailure extends UpdateDoctorScheduleState {
  final String error;

  const UpdateDoctorScheduleFailure({required this.error});

  @override
  List<Object> get props => [error];
}