import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_bloc.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_event.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_state.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentSuccesfulScreen extends StatelessWidget {
  final String doctorId;
  final String timeslotId;
  final String description;
  final int selectedDate;
  final int selectedMonth;
  final String selectedTime;
  const PaymentSuccesfulScreen(
      {super.key,
      required this.doctorId,
      required this.timeslotId,
      required this.description,
      required this.selectedDate,
      required this.selectedMonth,
      required this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.deepBlue,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Icon(
              Icons.check_circle_outline,
              size: 200,
              color: ColorPalette.whiteColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Congratulations',
              style: TextStyle(
                color: ColorPalette.whiteColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Booking Successful!',
              style: TextStyle(
                color: ColorPalette.whiteColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 160,
              width: 300,
              decoration: BoxDecoration(
                color: ColorPalette.deepBlue,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ColorPalette.whiteColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'You have successfully booked an',
                      style: TextStyle(color: ColorPalette.whiteColor),
                    ),
                    Text(
                      'appointment with',
                      style: TextStyle(color: ColorPalette.whiteColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocProvider(
                        create: (_) => GetDoctorInfoBloc(),
                        child: DoctorNameView(doctorId: doctorId)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: ColorPalette.whiteColor,
                        ),
                        Text(
                          '${DateTime.now().year} - $selectedMonth - $selectedDate',
                          style: TextStyle(color: ColorPalette.whiteColor),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.alarm,
                          color: ColorPalette.whiteColor,
                        ),
                        Text(
                          selectedTime,
                          style: TextStyle(color: ColorPalette.whiteColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CommonButton(
              width: 300,
              height: 48,
              onTap: () {
                NavigationServices(context).pushHomeScreen();
              },
              backgroundColor: ColorPalette.lightBlue,
              buttonTextWidget: Text(
                'Back to HomePage',
                style: TextStyle(
                  color: ColorPalette.deepBlue,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorNameView extends StatelessWidget {
  final String doctorId;
  const DoctorNameView({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GetDoctorInfoBloc>();
    bloc.add(GetDoctorInfoEvent(doctorId: doctorId));

    return BlocBuilder<GetDoctorInfoBloc, GetDoctorInfoState>(
        builder: (context, state) {
      if (state is GetDoctorInfoSuccess) {
        return Text(
          '${state.doctorInfo[0]['first_name']} ${state.doctorInfo[0]['last_name']}',
          style: TextStyle(
              color: ColorPalette.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
