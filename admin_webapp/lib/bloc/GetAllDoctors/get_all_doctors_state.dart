part of 'get_all_doctors_bloc.dart';

sealed class GetAllDoctorsState extends Equatable {
  const GetAllDoctorsState();

  @override
  List<Object> get props => [];
}

final class GetAllDoctorsInitial extends GetAllDoctorsState {}

final class GetAllDoctorsLoading extends GetAllDoctorsState {}

final class GetAllDoctorsSuccessfully extends GetAllDoctorsState {
  final List<Map<String, dynamic>> doctors;
  const GetAllDoctorsSuccessfully({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

final class GetAllDoctorsFailure extends GetAllDoctorsState {
  final String error;
  
  const GetAllDoctorsFailure({required this.error});

  @override
  List<Object> get props => [error];
}