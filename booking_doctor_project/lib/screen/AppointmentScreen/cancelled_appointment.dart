import 'package:booking_doctor_project/bloc/Appointment/CancelledAppointment/cancelled_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/CancelledAppointment/cancelled_appointment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/Appointment/CancelledAppointment/cancelled_appointment_event.dart';

class CancelledAppointment extends StatefulWidget {
  const CancelledAppointment({super.key});

  @override
  State<CancelledAppointment> createState() => _CancelledAppointmentState();
}

class _CancelledAppointmentState extends State<CancelledAppointment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CancelledAppointmentBloc>(context)
        .add(RequestCancelledAppointmentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancelledAppointmentBloc, CancelledAppointmentState>(
        builder: (BuildContext context, CancelledAppointmentState state) {
      return const Scaffold();
    });
  }
}
