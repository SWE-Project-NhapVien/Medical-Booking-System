import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_event.dart';
import 'package:booking_doctor_project/bloc/Appointment/UpcomingAppointment/upcoming_appointment_state.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatelessWidget {
  final String doctorId;
  final String timeslotId;
  final String description;
  final int selectedDate;
  final int selectedMonth;
  final String selectedTime;
  const PaymentScreen({
    super.key,
    required this.doctorId,
    required this.timeslotId,
    required this.description,
    required this.selectedDate,
    required this.selectedMonth,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpcomingAppointmentBloc(),
      child: Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: Column(
          children: [
            const CommonAppBarView(
              iconData: Icons.arrow_back_ios,
              title: '',
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                height: 400,
                width: 400,
                child: Image.asset('assets/images/payment.jpg')),
            const SizedBox(
              height: 40,
            ),
            BlocConsumer<UpcomingAppointmentBloc, UpcomingAppointmentState>(
              listener: (context, state) {},
              builder: (context, state) {
                return CommonButton(
                  width: 350,
                  height: 48,
                  onTap: () {
                    context
                        .read<UpcomingAppointmentBloc>()
                        .add(AddAppointmentEvent(
                          doctorId: doctorId,
                          patientId: GlobalProfile().profileId!,
                          timeslotId: timeslotId,
                          description: description,
                        ));
                    NavigationServices(context).pushPaymentSuccesfulScreen(
                        doctorId,
                        timeslotId,
                        description,
                        selectedDate,
                        selectedMonth,
                        selectedTime);
                  },
                  backgroundColor: ColorPalette.deepBlue,
                  buttonTextWidget: Text(
                    'Finish',
                    style: TextStyle(
                      color: ColorPalette.whiteColor,
                      fontSize: 24,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
