import 'package:booking_doctor_project/bloc/Appointment/CancelledAppointment/cancelled_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/CancelledAppointment/cancelled_appointment_event.dart';
import 'package:booking_doctor_project/bloc/Appointment/CancelledAppointment/cancelled_appointment_state.dart';
import 'package:booking_doctor_project/class/appointment.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/screen/AppointmentScreen/common_appointment_item.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelledAppointment extends StatefulWidget {
  const CancelledAppointment({super.key});

  @override
  State<CancelledAppointment> createState() => _CancelledAppointmentState();
}

class _CancelledAppointmentState extends State<CancelledAppointment> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    context.read<CancelledAppointmentBloc>().add(
        RequestCancelledAppointmentEvent(
            profileId: GlobalProfile().profileId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: BlocConsumer<CancelledAppointmentBloc, CancelledAppointmentState>(
            listener: (context, state) async {
          if (state is LoadingCancelledAppointmentState) {
            Dialogs(context).showLoadingDialog();
          } else if (state is ErrorCancelledAppointmentState) {
            Navigator.pop(context);
            Dialogs(context).showErrorDialog(message: state.message);
          } else if (state is SuccessCancelledAppointmentState) {
            Navigator.pop(context);
            appointments = state.appointments;
          }
        }, builder: (context, state) {
          if (appointments.isEmpty) {
            return Center(
              child: Text(
                'Have no cancelled appointments.',
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
                  time: appointment.appointmentTime.substring(0, 5),
                  onTap: () {
                    NavigationServices(context)
                        .pushAppointmentDetail(appointment: appointment);
                  },
                  doctorImage: appointment.doctorAvatar ?? '',
                  price: appointment.price.toString(),
                );
              },
            );
          }
        }));
  }
}
