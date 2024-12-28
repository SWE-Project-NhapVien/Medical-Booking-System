import 'package:doctor_webapp/bloc/Appointment/appointment_bloc.dart';
import 'package:doctor_webapp/bloc/Appointment/appointment_event.dart';
import 'package:doctor_webapp/bloc/Appointment/appointment_state.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment2/specific_appointment2_bloc.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment2/specific_appointment2_event.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment2/specific_appointment2_state.dart';
import 'package:doctor_webapp/screen/appointment/common_appointment_card.dart';
import 'package:doctor_webapp/utils/fixed_web_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CompletedAppointmentScreen extends StatefulWidget {
  const CompletedAppointmentScreen({super.key});

  @override
  State<CompletedAppointmentScreen> createState() =>
      _CompletedAppointmentScreenState();
}

class _CompletedAppointmentScreenState
    extends State<CompletedAppointmentScreen> {
  @override
  void didChangeDependencies() {
    context
        .read<AppointmentBloc>()
        .add(RequestAppointmentEvent(appointmentType: 'Completed'));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double lottieSize = MediaQuery.of(context).size.width * 0.2;
    return BlocConsumer<GetSpecificAppointmentDataBloc2,
        GetSpecificAppointmentDataState2>(
      listener: (context, state3) {
        if (state3 is GetSpecificAppointmentDataSuccess2) {
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
                            .read<GetSpecificAppointmentDataBloc2>()
                            .add(GetSpecificAppointmentDataEvent2(
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
