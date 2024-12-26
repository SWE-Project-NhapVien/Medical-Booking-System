part of 'get_all_patients_bloc.dart';

sealed class GetAllPatientsState extends Equatable {
  const GetAllPatientsState();
  
  @override
  List<Object> get props => [];
}

final class GetAllPatientsInitial extends GetAllPatientsState {}
final class GetAllPatientsLoading extends GetAllPatientsState {}
final class GetAllPatientsSuccessfully extends GetAllPatientsState {
  final List<Patient> patients;
  
  const GetAllPatientsSuccessfully({required this.patients});
  
  @override
  List<Object> get props => [patients];
}
final class GetAllPatientsFailure extends GetAllPatientsState {
  final String error;
  
  const GetAllPatientsFailure({required this.error});
  
  @override
  List<Object> get props => [error];
}