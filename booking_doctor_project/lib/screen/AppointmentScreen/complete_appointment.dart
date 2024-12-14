import 'package:booking_doctor_project/bloc/Appointment/CompleteAppointment/complete_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/CompleteAppointment/complete_appointment_event.dart';
import 'package:booking_doctor_project/bloc/Appointment/CompleteAppointment/complete_appointment_state.dart';
import 'package:booking_doctor_project/class/appointment.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common_appointment_item.dart';

class CompleteAppointment extends StatefulWidget {
  const CompleteAppointment({super.key});

  @override
  State<CompleteAppointment> createState() => _CompleteAppointmentState();
}

class _CompleteAppointmentState extends State<CompleteAppointment> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    context.read<CompleteAppointmentBloc>().add(
        RequestCompleteAppointmentEvent(profileId: GlobalProfile().profileId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: BlocConsumer<CompleteAppointmentBloc, CompleteAppointmentState>(
          listener: (context, state) async {
            if (state is LoadingCompleteAppointmentState) {
              Dialogs(context).showLoadingDialog();
            } else if (state is ErrorCompleteAppointmentState) {
              Navigator.pop(context);
              Dialogs(context).showErrorDialog(message: state.message);
            } else if (state is SuccessCompleteAppointmentState) {
              Navigator.pop(context);
              appointments = state.appointments;
            }
          },
          builder: (context, state) {
            if (appointments.isEmpty) {
              return Center(
                child: Text(
                  'Have no completed appointments.',
                  style: TextStyles(context).getRegularStyle(
                    color: ColorPalette.blackColor,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return AppointmentCard(
                    doctorName: appointment.doctorFullName,
                    appointmentName: appointment.specializations.join(', '),
                    date: appointment.appointmentDate,
                    time: appointment.appointmentTime,
                    onTap: () {
                      NavigationServices(context)
                          .pushAppointmentDetail(appointment: appointment);
                    },
                    doctorImage: appointment.doctorAvatar ?? '',
                  );
                },
              );
            }
          },
        ));
  }
}
