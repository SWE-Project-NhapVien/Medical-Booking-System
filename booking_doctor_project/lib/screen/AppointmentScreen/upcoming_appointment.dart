import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_event.dart';
import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_state.dart';
import 'package:booking_doctor_project/class/appointment.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/screen/AppointmentScreen/common_appointment_item.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingAppointment extends StatefulWidget {
  const UpcomingAppointment({super.key});

  @override
  State<UpcomingAppointment> createState() => _UpcomingAppointmentState();
}

class _UpcomingAppointmentState extends State<UpcomingAppointment> {
  List<Appointment> appointments = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<UpcomingAppointmentBloc>().add(
        RequestUpcomingAppointmentEvent(profileId: GlobalProfile().profileId!));
  }

  @override
  void initState() {
    // context.read<UpcomingAppointmentBloc>().add(
    //     RequestUpcomingAppointmentEvent(profileId: GlobalProfile().profileId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: BlocConsumer<UpcomingAppointmentBloc, UpcomingAppointmentState>(
          listener: (context, state) async {
            if (state is LoadingUpcomingAppointmentState) {
              Dialogs(context).showLoadingDialog();
            } else if (state is ErrorUpcomingAppointmentState) {
              Navigator.pop(context);
              Dialogs(context).showErrorDialog(message: state.message);
            } else if (state is SuccessUpcomingAppointmentState) {
              Navigator.pop(context);
              appointments = state.appointments;
            }
          },
          builder: (context, state) {
            if (appointments.isEmpty) {
              return Center(
                child: Text(
                  'Have no upcoming appointments.',
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
                    price: appointment.price.toString(),
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
