part of 'create_doctor_profile_bloc.dart';

abstract class CreateDoctorProfileEvent extends Equatable {
  const CreateDoctorProfileEvent();

  @override
  List<Object?> get props => [];
}

class CreateDoctorProfileRequired extends CreateDoctorProfileEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dateOfBirth;
  final String bloodType;
  final String gender;
  final String address;
  final String education;
  final String career;
  final String description;
  final String avaUrl;
  final List<String> specialization;

  const CreateDoctorProfileRequired({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.bloodType,
    required this.gender,
    required this.address,
    required this.education,
    required this.career,
    required this.description,
    required this.avaUrl,
    required this.specialization,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        dateOfBirth,
        bloodType,
        gender,
        address,
        education,
        career,
        description,
        avaUrl,
        specialization,
      ];
}

class CreateDoctorProfileReset extends CreateDoctorProfileEvent {}
