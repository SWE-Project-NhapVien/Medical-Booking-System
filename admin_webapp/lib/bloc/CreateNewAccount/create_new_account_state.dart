part of 'create_new_account_bloc.dart';

sealed class CreateNewAccountState extends Equatable {
  const CreateNewAccountState();
  
  @override
  List<Object> get props => [];
}

final class CreateNewAccountInitial extends CreateNewAccountState {}

final class CreateNewAccountProcess extends CreateNewAccountState {}

final class CreateNewAccountSuccess extends CreateNewAccountState {}

final class CreateNewAccountFailure extends CreateNewAccountState {
  final String error;

  const CreateNewAccountFailure({required this.error});

  @override
  List<Object> get props => [error];
}