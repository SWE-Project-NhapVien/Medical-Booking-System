import 'package:booking_doctor_project/bloc/Appointment/SpecificAppointment/specific_appointment_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/SpecificAppointment/specific_appointment_event.dart';
import 'package:booking_doctor_project/bloc/Appointment/SpecificAppointment/specific_appointment_state.dart';
import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_event.dart';
import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_state.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: BlocProvider(
          create: (_) => GetProfileInfoBloc(),
          child: HomeScreenView(profileId: GlobalProfile().profileId!),
        ));
  }
}

class HomeScreenView extends StatefulWidget {
  final String profileId;
  const HomeScreenView({super.key, required this.profileId});

  @override
  State<HomeScreenView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenView> {
  @override
  void didChangeDependencies() {
    context
        .read<GetProfileInfoBloc>()
        .add(GetProfileInfoEvent(profileId: GlobalProfile().profileId!));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileInfoBloc, GetProfileInfoState>(
        builder: (context, state) {
      if (state is GetProfileInfoLoading) {
        return Center(
          child: Center(
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: 100,
              ),
            ),
          ),
        );
      } else if (state is GetProfileInfoSuccess) {
        bool unreadNoti = false;
        List<String> notiList = [];
        if (state.profileInfo[0]['notification_id'] != null) {
          for (int i = 0; i < state.profileInfo.length; i++) {
            if (state.profileInfo[i]['read_status'] == false) {
              unreadNoti = true;
              break;
            }
          }
          for (int i = 0; i < state.profileInfo.length; i++) {
            state.profileInfo[i]['notification_id'] ??
                notiList.add(state.profileInfo[i]['notification_id']);
          }
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: Image.network(
                          state.profileInfo[0]['ava_url'] ??
                              'https://vikaxjhrmnewkrlovxmi.supabase.co/storage/v1/object/public/web/default_avatar.png',
                        ).image)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Welcome back!",
                        style: TextStyle(
                            color: ColorPalette.deepBlue, fontSize: 14),
                      ),
                      Text(
                        "${state.profileInfo[0]['first_name']} ${state.profileInfo[0]['last_name']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      NavigationServices(context)
                          .pushNotificationScreen(notiList)
                          .then((_) => context.read<GetProfileInfoBloc>().add(
                              GetProfileInfoEvent(
                                  profileId:
                                      GlobalProfile().profileId!))); // Refresh
                    },
                    child: Container(
                      width: 36.0, // Width of the button
                      height:
                          36.0, // Height of the button (same as width for circular shape)
                      decoration: BoxDecoration(
                        color: ColorPalette.mediumBlue, // Blue background
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: unreadNoti == false
                          ? const Icon(
                              Icons
                                  .notifications_outlined, // Magnifying glass icon
                              color: Colors.black, // White color for the icon
                              size: 24.0, // Icon size
                            )
                          : Stack(
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons
                                        .notifications_outlined, // Magnifying glass icon
                                    color: Colors
                                        .black, // White color for the icon
                                    size: 24.0, // Icon size
                                  ),
                                ),
                                Positioned(
                                  right: 10, // Position from the right
                                  top: 10,
                                  child: Container(
                                    width: 6, // Diameter of the circle
                                    height: 6, // Diameter of the circle
                                    decoration: const BoxDecoration(
                                      color: Colors.red, // Fill color
                                      shape: BoxShape.circle, // Circular shape
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Image(
                    image: AssetImage('assets/images/doctors_image.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: TextField(
                        style: TextStyle(color: ColorPalette.deepBlue),
                        showCursor: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 14.0), // Padding inside the text field
                          hintText: 'Search',
                          hintStyle: TextStyle(color: ColorPalette.deepBlue),
                          fillColor: ColorPalette.mediumBlue,
                          filled: true,
                          suffixIconColor: ColorPalette.deepBlue,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Rounded border
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          NavigationServices(context).pushSearchScreen();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 36.0, // Width of the button
                      height:
                          36.0, // Height of the button (same as width for circular shape)
                      decoration: BoxDecoration(
                        color: ColorPalette.deepBlue, // Blue background
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: const Icon(
                        Icons.search, // Magnifying glass icon
                        color: Colors.white, // White color for the icon
                        size: 20.0, // Icon size
                      ),
                    ),
                    onTap: () {
                      NavigationServices(context).pushSearchScreen();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Upcoming ",
                    style: TextStyle(
                      color: ColorPalette.deepBlue,
                    ),
                  ),
                  Dash(
                    direction: Axis.horizontal, // Horizontal dashed line
                    length: (MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width * 0.1) -
                        70, // Length of the line
                    dashLength: 6, // Length of each dash
                    dashColor: ColorPalette.deepBlue, // Color of the dashes
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              BlocProvider(
                create: (_) => GetSpecificAppointmentDataBloc(),
                child: UpcomingAppointmentView(
                    appointmentId:
                        state.profileInfo[0]['appointment_id'] ?? ''),
              )
            ],
          ),
        );
      } else if (state is GetProfileInfoError) {
        return Center(
          child: Text(state.error),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

class UpcomingAppointmentView extends StatelessWidget {
  final String appointmentId;
  const UpcomingAppointmentView({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GetSpecificAppointmentDataBloc>();
    bloc.add(GetSpecificAppointmentDataEvent(appointmentId: appointmentId));
    return BlocBuilder<GetSpecificAppointmentDataBloc,
        GetSpecificAppointmentDataState>(builder: (context, state) {
      if (state is GetSpecificAppointmentDataLoading) {
        return Center(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset(
              Localfiles.loading,
              width: 100,
            ),
          ),
        );
      } else if (state is GetSpecificAppointmentDataSuccess) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorPalette.mediumBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: Image.network(
                                state.appointmentData[0]['ava_url'] ??
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
                              "${state.appointmentData[0]['first_name']} ${state.appointmentData[0]['last_name']}",
                              style: TextStyle(
                                  color: ColorPalette.deepBlue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              state.appointmentData[0]['specialization']
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', ''),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 110,
                          height: 24,
                          decoration: BoxDecoration(
                            color: ColorPalette.whiteColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: ColorPalette.deepBlue,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${state.appointmentData[0]['appointment_date']}",
                                style: TextStyle(
                                  color: ColorPalette.deepBlue,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 90,
                          height: 24,
                          decoration: BoxDecoration(
                            color: ColorPalette.whiteColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.alarm_on_outlined,
                                color: ColorPalette.deepBlue,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${state.appointmentData[0]['appointment_time']}",
                                style: TextStyle(
                                  color: ColorPalette.deepBlue,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      } else if (state is GetSpecificAppointmentDataError) {
        return Center(
          child: Text(
            'No upcoming appointment',
            style: TextStyle(color: ColorPalette.greyColor),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
