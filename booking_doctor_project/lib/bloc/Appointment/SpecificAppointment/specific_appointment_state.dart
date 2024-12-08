sealed class GetSpecificAppointmentDataState {}

class GetSpecificAppointmentDataInitial
    extends GetSpecificAppointmentDataState {}

class GetSpecificAppointmentDataLoading
    extends GetSpecificAppointmentDataState {}

class GetSpecificAppointmentDataSuccess
    extends GetSpecificAppointmentDataState {
  final List appointmentData;
  GetSpecificAppointmentDataSuccess(this.appointmentData);
}

class GetSpecificAppointmentDataError extends GetSpecificAppointmentDataState {
  final String message;
  GetSpecificAppointmentDataError(this.message);
}
