sealed class GetSpecificAppointmentDataState2 {}

class GetSpecificAppointmentDataInitial2
    extends GetSpecificAppointmentDataState2 {}

class GetSpecificAppointmentDataLoading2
    extends GetSpecificAppointmentDataState2 {}

class GetSpecificAppointmentDataSuccess2
    extends GetSpecificAppointmentDataState2 {
  final List appointmentData;
  GetSpecificAppointmentDataSuccess2(this.appointmentData);
}

class GetSpecificAppointmentDataError2
    extends GetSpecificAppointmentDataState2 {
  final String message;
  GetSpecificAppointmentDataError2(this.message);
}
