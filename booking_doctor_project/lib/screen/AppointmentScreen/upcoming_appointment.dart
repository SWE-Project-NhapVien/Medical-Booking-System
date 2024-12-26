import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_event.dart';
import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_state.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/screen/AppointmentScreen/common_appointment_item.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class UpcomingAppointment extends StatefulWidget {
  const UpcomingAppointment({super.key});

  @override
  State<UpcomingAppointment> createState() => _UpcomingAppointmentState();
}

class _UpcomingAppointmentState extends State<UpcomingAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: BlocProvider(
        create: (context) => UpcomingAppointmentBloc(),
        child: const UpcomingAppointmentView(),
      ),
    );
  }
}

class UpcomingAppointmentView extends StatefulWidget {
  const UpcomingAppointmentView({super.key});

  @override
  State<UpcomingAppointmentView> createState() =>
      _UpcomingAppointmentViewState();
}

class _UpcomingAppointmentViewState extends State<UpcomingAppointmentView> {
  @override
  Widget build(BuildContext context) {
    context.read<UpcomingAppointmentBloc>().add(
        RequestUpcomingAppointmentEvent(profileId: GlobalProfile().profileId!));
    return BlocBuilder<UpcomingAppointmentBloc, UpcomingAppointmentState>(
      builder: (context, state) {
        if (state is LoadingUpcomingAppointmentState) {
          return Center(
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: 100,
              ),
            ),
          );
        } else if (state is SuccessUpcomingAppointmentState) {
          if (state.appointments.isEmpty) {
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
              padding: EdgeInsets.zero,
              itemCount: state.appointments.length,
              itemBuilder: (context, index) {
                final appointment = state.appointments[index];
                return AppointmentCard(
                  doctorName: appointment.doctorFullName,
                  appointmentName: appointment.specializations.join(', '),
                  date: appointment.appointmentDate,
                  time: appointment.appointmentTime.substring(0, 5),
                  price: appointment.price.toString(),
                  onTap: () async {
                    await NavigationServices(context)
                        .pushAppointmentDetail(appointment: appointment)
                        .then((_) {
                      setState(() {});
                    });
                  },
                  doctorImage: appointment.doctorAvatar ?? '',
                );
              },
            );
          }
        } else if (state is ErrorUpcomingAppointmentState) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
