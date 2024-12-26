part of 'get_all_doctors_bloc.dart';

sealed class GetAllDoctorsState extends Equatable {
  const GetAllDoctorsState();
  
  @override
  List<Object> get props => [];
}

final class GetAllDoctorsInitial extends GetAllDoctorsState {}
