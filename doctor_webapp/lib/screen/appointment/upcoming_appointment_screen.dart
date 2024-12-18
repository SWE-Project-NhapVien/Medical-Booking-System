import 'package:doctor_webapp/bloc/Appointment/appointment_state.dart';
import 'package:doctor_webapp/screen/appointment/common_appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/Appointment/appointment_bloc.dart';
import '../../bloc/Appointment/appointment_event.dart';
import '../../utils/fixed_web_component.dart';

class UpcomingAppointmentScreen extends StatefulWidget {
  const UpcomingAppointmentScreen({super.key});

  @override
  State<UpcomingAppointmentScreen> createState() =>
      _UpcomingAppointmentScreenState();
}

class _UpcomingAppointmentScreenState extends State<UpcomingAppointmentScreen> {
  @override
  void didChangeDependencies() {
    context
        .read<AppointmentBloc>()
        .add(RequestAppointmentEvent(appointmentType: 'Upcoming'));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    return BlocConsumer<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
      if (state is LoadingAppointmentState) {
        Center(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset(
              FixedWebComponent.loading,
              width: lottieSize,
            ),
          ),
        );
      } else if (state is ErrorAppointmentState) {
        print(state.message);
      }
    }, builder: (context, state) {
      if (state is SucessAppointmentState) {
        final List<AppointmentCard> _list = state.appointment
            .map((e) => AppointmentCard(
                  appointmentId: e.appointmentId,
                  patientFullName: e.patientFullName,
                  date: e.date,
                  time: e.time,
                  patientAvatarURL: e.patientAvatarURL ??
                      FixedWebComponent.defaultPatientAvatar,
                  onTap: () {},
                ))
            .toList();
        return ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return _list[index];
          },
        );
      }
      return Container();
    });
  }
}
