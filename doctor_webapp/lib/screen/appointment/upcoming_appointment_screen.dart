import 'package:doctor_webapp/bloc/Appointment/appointment_state.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment/specific_appointment_bloc.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment/specific_appointment_event.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment/specific_appointment_state.dart';
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
    return BlocConsumer<GetSpecificAppointmentDataBloc,
        GetSpecificAppointmentDataState>(
      listener: (context, state2) {
        if (state2 is GetSpecificAppointmentDataSuccess) {
          setState(() {});
        }
      },
      builder: (context, state) {
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
          }
        }, builder: (context, state) {
          if (state is SucessAppointmentState) {
            final List<AppointmentCard> list = state.appointment
                .map((e) => AppointmentCard(
                      appointmentId: e.appointmentId,
                      patientFullName: e.patientFullName,
                      date: e.date,
                      time: e.time,
                      patientAvatarURL:
                          e.patientAvatarURL != '' && e.patientAvatarURL != null
                              ? e.patientAvatarURL!
                              : FixedWebComponent.defaultPatientAvatar,
                      onTap: () {
                        context
                            .read<GetSpecificAppointmentDataBloc>()
                            .add(GetSpecificAppointmentDataEvent(
                              appointmentId: e.appointmentId,
                            ));
                      },
                    ))
                .toList();
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return list[index];
              },
            );
          }
          return Container();
        });
      },
    );
  }
}
