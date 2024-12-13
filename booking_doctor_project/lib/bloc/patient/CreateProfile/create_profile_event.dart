part of 'create_profile_bloc.dart';

sealed class CreateProfileEvent extends Equatable {
  const CreateProfileEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CreateProfileRequired extends CreateProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String bloodType;
  String gender;
  String address;
  double? height;
  double? weight;
  final List<String> emergencyContact;
  final String? relationship;

  CreateProfileRequired({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.bloodType,
    this.gender = '',
    this.address = '',
    this.height,
    this.weight,
    required this.emergencyContact,
    this.relationship,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        phoneNumber,
        dateOfBirth,
        bloodType,
        emergencyContact,
      ];
}

class CreateProfileReset extends CreateProfileEvent {}
