import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_bloc.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_event.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_state.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadyPaymentScreen extends StatelessWidget {
  final String doctorId;
  final String timeslotId;
  final int selectedDate;
  final int selectedMonth;
  final String selectedTime;
  final String description;
  const ReadyPaymentScreen(
      {super.key,
      required this.doctorId,
      required this.timeslotId,
      required this.selectedDate,
      required this.selectedMonth,
      required this.selectedTime,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.deepBlue,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              AppBar().preferredSize.height,
              MediaQuery.of(context).size.width * 0.1,
              MediaQuery.of(context).size.height * 0.01,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios,
                      color: ColorPalette.whiteColor),
                ),
                Expanded(
                  child: Center(
                    child: Text('Payment',
                        style: TextStyles(context).getBoldStyle(
                            fontSize: 24.0, color: ColorPalette.whiteColor)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text('125.000 VND',
                    style: TextStyles(context).getBoldStyle(
                        fontSize: 48.0, color: ColorPalette.whiteColor)),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: ColorPalette.whiteColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                child: Column(
                  children: [
                    BlocProvider(
                      create: (_) => GetDoctorInfoBloc(),
                      child: DoctorInfoView(doctorId: doctorId),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: ColorPalette.deepBlue,
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('Date / Hour',
                            style: TextStyle(color: ColorPalette.deepBlue)),
                        const Spacer(),
                        Text(
                            '${DateTime.now().year} - $selectedMonth - $selectedDate / $selectedTime',
                            style: TextStyle(color: ColorPalette.blackColor)),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text('Duration',
                            style: TextStyle(color: ColorPalette.deepBlue)),
                        const Spacer(),
                        Text('30 minutes',
                            style: TextStyle(color: ColorPalette.blackColor)),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: ColorPalette.deepBlue,
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    CommonButton(
                      height: 48,
                      onTap: () {
                        NavigationServices(context).pushPaymentScreen(
                          doctorId,
                          timeslotId,
                          description,
                          selectedDate,
                          selectedMonth,
                          selectedTime,
                        );
                      },
                      backgroundColor: ColorPalette.deepBlue,
                      buttonTextWidget: Text(
                        'Pay Now',
                        style: TextStyle(
                          color: ColorPalette.whiteColor,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorInfoView extends StatelessWidget {
  final String doctorId;
  const DoctorInfoView({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GetDoctorInfoBloc>();
    bloc.add(GetDoctorInfoEvent(doctorId: doctorId));
    return BlocBuilder<GetDoctorInfoBloc, GetDoctorInfoState>(
        builder: (context, state) {
      if (state is GetDoctorInfoSuccess) {
        return Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: Image.network(
                    state.doctorInfo[0]['ava_url'] ??
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2F8DoZLvVpkbPZs1z1dBzXKLvgRNwgUrstA&s',
                  ).image)),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${state.doctorInfo[0]['first_name']} ${state.doctorInfo[0]['last_name']}",
                  style: TextStyle(
                      color: ColorPalette.deepBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  state.doctorInfo[0]['specialization']
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', ''),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.lightBlue,
              ),
              child: Icon(
                Icons.star,
                color: ColorPalette.deepBlue,
              ),
            ),
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
