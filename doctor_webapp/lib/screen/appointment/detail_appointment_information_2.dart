import 'package:doctor_webapp/bloc/SpecificAppointment2/specific_appointment2_bloc.dart';
import 'package:doctor_webapp/bloc/SpecificAppointment2/specific_appointment2_state.dart';
import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:doctor_webapp/utils/fixed_web_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailAppointmentInformation2 extends StatefulWidget {
  const DetailAppointmentInformation2({super.key});

  @override
  State<DetailAppointmentInformation2> createState() =>
      _DetailAppointmentInformation2State();
}

class _DetailAppointmentInformation2State
    extends State<DetailAppointmentInformation2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSpecificAppointmentDataBloc2,
        GetSpecificAppointmentDataState2>(builder: (context, state) {
      if (state is GetSpecificAppointmentDataSuccess2) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorPalette.deepBlue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Appointment Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.whiteColor,
                    )),
                const SizedBox(height: 40),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(state.appointmentData[0]
                          ['ava_url'] ??
                      FixedWebComponent.defaultPatientAvatar),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: ColorPalette.whiteColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.appointmentData[0]['first_name']} ${state.appointmentData[0]['last_name']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.blackColor,
                              ),
                            ),
                            Divider(
                              color: ColorPalette.deepBlue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Date of Birth',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.appointmentData[0]['date_of_birth']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.blackColor,
                              ),
                            ),
                            Divider(
                              color: ColorPalette.deepBlue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.appointmentData[0]['gender']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.blackColor,
                              ),
                            ),
                            Divider(
                              color: ColorPalette.deepBlue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.appointmentData[0]['appointment_date']} ${state.appointmentData[0]['appointment_time']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.blackColor,
                              ),
                            ),
                            Divider(
                              color: ColorPalette.deepBlue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.appointmentData[0]['description']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.blackColor,
                              ),
                            ),
                            Divider(
                              color: ColorPalette.deepBlue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Symptoms',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.appointmentData[0]['symptoms']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.blackColor,
                              ),
                            ),
                            Divider(
                              color: ColorPalette.deepBlue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'diagnosis',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${state.appointmentData[0]['diagnosis']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.blackColor,
                              ),
                            ),
                            Divider(
                              color: ColorPalette.deepBlue,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Prescriptions',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.deepBlue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.appointmentData[0]['prescriptions']
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorPalette.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorPalette.deepBlue,
        ),
      );
    });
  }
}
