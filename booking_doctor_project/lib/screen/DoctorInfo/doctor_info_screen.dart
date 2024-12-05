import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_bloc.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_event.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_state.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:booking_doctor_project/widgets/comon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorInfoScreen extends StatelessWidget {
  final String doctorId;
  const DoctorInfoScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonAppBarView(
              iconData: Icons.arrow_back_ios,
              title: "Doctor Info",
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            BlocProvider(
              create: (_) => GetDoctorInfoBloc(),
              child: DoctorInfoView(doctorId: doctorId),
            )
          ],
        ),
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
        if (state is GetDoctorInfoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetDoctorInfoSuccess) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 335,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: ColorPalette.mediumBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: Image.network(
                              state.doctorInfo[0]['ava_url'],
                            ).image)),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 40,
                        width: 180,
                        decoration: BoxDecoration(
                          color: ColorPalette.deepBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
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
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'NhapVien Expert',
                              style: TextStyle(color: ColorPalette.whiteColor),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: ColorPalette.whiteColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              Align(
                                child: Text(
                                  "${state.doctorInfo[0]['first_name']} ${state.doctorInfo[0]['last_name']}",
                                  style: TextStyle(
                                      color: ColorPalette.deepBlue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                state.doctorInfo[0]['specialization']
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Education & Certification',
                  style: TextStyle(
                    color: ColorPalette.deepBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(state.doctorInfo[0]['education']),
                const SizedBox(height: 10),
                Text(
                  'Career Path',
                  style: TextStyle(
                    color: ColorPalette.deepBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(state.doctorInfo[0]['career']),
                const SizedBox(height: 10),
                Text(
                  'General description',
                  style: TextStyle(
                    color: ColorPalette.deepBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(state.doctorInfo[0]['description']),
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 180,
                    child: CommonButton(
                      onTap: () {},
                      backgroundColor: ColorPalette.deepBlue,
                      buttonTextWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: ColorPalette.whiteColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Schedule',
                            style: TextStyle(
                              color: ColorPalette.whiteColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state is GetDoctorInfoError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
