import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_bloc.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_event.dart';
import 'package:booking_doctor_project/bloc/DoctorInfo/doctor_info_state.dart';
import 'package:booking_doctor_project/bloc/TimeSlot/timeslot_bloc.dart';
import 'package:booking_doctor_project/bloc/TimeSlot/timeslot_event.dart';
import 'package:booking_doctor_project/bloc/TimeSlot/timeslot_state.dart';
import 'package:booking_doctor_project/class/patient_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/color_palette.dart';
import '../../../widgets/common_button.dart';

class ScheduleScreen extends StatefulWidget {
  final String doctorId;
  const ScheduleScreen({super.key, required this.doctorId});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late int selectedDate;
  late int selectedMonth;
  late String selectedTime;
  late Map<int, List<String>> daysInWeekByMonth;
  late TextEditingController descriptionController;
  late ScrollController scrollController;
  late String timeslotId;
  late Future<PatientProfile?> patientProfile;

  @override
  void initState() {
    selectedDate = DateTime.now().day;
    selectedMonth = DateTime.now().month;
    daysInWeekByMonth = generateDaysInWeekByMonth();
    descriptionController = TextEditingController();
    scrollController = ScrollController();
    selectedTime = '';
    timeslotId = '';
    patientProfile = PatientProfile.getProfile();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo((selectedDate - 1) * 70.0);
    });
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: CommonAppBarView(
                    title: '',
                    iconData: Icons.arrow_back_ios_new_rounded,
                    onBackClick: () async {
                      await Dialogs(context).showErrorDialog(
                          title: "Appointment Discard",
                          message: "This appointment will be discarded");
                      // Navigate to previous screen here
                      Navigator.pop(context);
                    },
                  ),
                ),
                BlocProvider(
                  create: (_) => GetDoctorInfoBloc(),
                  child: DoctorNameView(doctorId: widget.doctorId),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 160,
                      color: ColorPalette.mediumBlue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: DropdownButton(
                                  style: TextStyle(
                                      color: ColorPalette.deepBlue,
                                      fontSize: 18),
                                  iconEnabledColor: ColorPalette.deepBlue,
                                  iconDisabledColor: ColorPalette.deepBlue,
                                  underline: const SizedBox(),
                                  value: selectedMonth,
                                  items: const [
                                    DropdownMenuItem(
                                        value: 1, child: Text('January')),
                                    DropdownMenuItem(
                                        value: 2, child: Text('February')),
                                    DropdownMenuItem(
                                        value: 3, child: Text('March')),
                                    DropdownMenuItem(
                                        value: 4, child: Text('April')),
                                    DropdownMenuItem(
                                        value: 5, child: Text('May')),
                                    DropdownMenuItem(
                                        value: 6, child: Text('June')),
                                    DropdownMenuItem(
                                        value: 7, child: Text('July')),
                                    DropdownMenuItem(
                                        value: 8, child: Text('August')),
                                    DropdownMenuItem(
                                        value: 9, child: Text('September')),
                                    DropdownMenuItem(
                                        value: 10, child: Text('October')),
                                    DropdownMenuItem(
                                        value: 11, child: Text('November')),
                                    DropdownMenuItem(
                                        value: 12, child: Text('December')),
                                  ],
                                  onChanged: (value) {
                                    if (value as int >= DateTime.now().month) {
                                      setState(() {
                                        selectedMonth = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 90,
                              child: ListView.builder(
                                controller: scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    daysInWeekByMonth[selectedMonth]!.length,
                                itemBuilder: (context, index) {
                                  String date =
                                      daysInWeekByMonth[selectedMonth]![index];
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (index + 1 >= DateTime.now().day) {
                                            setState(() {
                                              selectedDate = index + 1;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: selectedDate - 1 == index
                                                  ? ColorPalette.deepBlue
                                                  : ColorPalette.whiteColor),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: selectedDate - 1 ==
                                                            index
                                                        ? ColorPalette
                                                            .whiteColor
                                                        : ColorPalette
                                                            .blackColor),
                                              ),
                                              Text(
                                                date,
                                                style: TextStyle(
                                                    color: selectedDate - 1 ==
                                                            index
                                                        ? ColorPalette
                                                            .whiteColor
                                                        : ColorPalette
                                                            .blackColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Available Time",
                    style: TextStyle(
                        color: ColorPalette.deepBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BlocProvider(
                    create: (_) => GetTimeSlotDataBloc(),
                    child: TimeSlotView(
                      doctorId: widget.doctorId,
                      date:
                          '${DateTime.now().year}-$selectedMonth-$selectedDate',
                      onTimeSelected: (value) {
                        List<String> tmp = value.split(' ');
                        selectedTime = tmp[0];
                        timeslotId = tmp[1];
                      },
                    ),
                  ),
                  Divider(
                    color: ColorPalette.deepBlue,
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Patient Details",
                    style: TextStyle(
                        color: ColorPalette.deepBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                      future: patientProfile,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Lottie.asset(
                                Localfiles.loading,
                                width: 100,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('No patient profile found'),
                          );
                        }
                        final profile = snapshot.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Fullname",
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorPalette.lightBlue,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      '${profile!.firstName} ${profile.lastName}',
                                      style: TextStyle(
                                          color: ColorPalette.deepBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Age",
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorPalette.lightBlue,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      '${DateTime.now().year - int.parse(profile.dob.substring(0, 4))}',
                                      style: TextStyle(
                                          color: ColorPalette.deepBlue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Gender",
                            ),
                            Container(
                              height: 32,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorPalette.deepBlue,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  profile.gender,
                                  style: TextStyle(
                                      color: ColorPalette.whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: ColorPalette.deepBlue,
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Describe your problem",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 100, // Set height for the text box
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: ColorPalette.deepBlue, // Light blue border
                      ),
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2), // Spacing inside the text box
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Enter Your Problem Here',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontSize: 14, color: ColorPalette.blackColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButton(
                    onTap: () {
                      if (descriptionController.text.isEmpty) {
                        Dialogs(context).showErrorDialog(
                            title: 'Error',
                            message: 'Please enter your problem');
                      } else if (selectedTime.isEmpty) {
                        Dialogs(context).showErrorDialog(
                            title: 'Error',
                            message: 'Please select a time slot');
                      } else {
                        NavigationServices(context).pushReadyPaymentScreen(
                          widget.doctorId,
                          timeslotId,
                          selectedDate,
                          selectedMonth,
                          selectedTime,
                          descriptionController.text,
                        );
                      }
                    },
                    backgroundColor: ColorPalette.deepBlue,
                    buttonText: 'Book',
                    textColor: ColorPalette.whiteColor,
                    fontSize: 28,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<int, List<String>> generateDaysInWeekByMonth() {
    List<String> weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    Map<int, List<String>> result = {};

    for (int month = 1; month <= 12; month++) {
      // Map the weekdays to the days in the month
      List<String> daysInMonth = [];
      for (int day = 1;
          day <= DateTime(DateTime.now().year, month + 1, 0).day;
          day++) {
        DateTime currentDay = DateTime(DateTime.now().year, month, day);
        daysInMonth.add(weekdays[currentDay.weekday - 1]);
      }

      result[month] = daysInMonth;
    }

    return result;
  }
}

class TimeSlotView extends StatefulWidget {
  final String doctorId;
  final String date;
  final void Function(String selectedTime) onTimeSelected;

  const TimeSlotView({
    super.key,
    required this.doctorId,
    required this.date,
    required this.onTimeSelected,
  });

  @override
  State<TimeSlotView> createState() => _TimeSlotViewState();
}

class _TimeSlotViewState extends State<TimeSlotView> {
  late String selectedTime;

  @override
  void initState() {
    selectedTime = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc2 = context.read<GetTimeSlotDataBloc>();
    bloc2.add(GetTimeSlotEvent(doctorId: widget.doctorId, date: widget.date));

    return BlocBuilder<GetTimeSlotDataBloc, GetTimeSlotState>(
        builder: (context, state) {
      if (state is GetTimeSlotLoading) {
        return Center(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset(
              Localfiles.loading,
              width: 100,
            ),
          ),
        );
      } else if (state is GetTimeSlotSuccess) {
        List<String> timeSlots = [];
        for (int i = 0; i < state.timeSlot.length; i++) {
          timeSlots
              .add(state.timeSlot[i]['timeslot'].toString().substring(0, 5));
        }
        List<bool> timeSlotsStatus = [];
        for (int i = 0; i < state.timeSlot.length; i++) {
          timeSlotsStatus.add(state.timeSlot[i]['status']);
        }
        return SizedBox(
          height: 150,
          child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, crossAxisSpacing: 0, mainAxisSpacing: 0),
              itemCount: state.timeSlot.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (timeSlotsStatus[index] == true) {
                        setState(() {
                          selectedTime = timeSlots[index];
                          String tmp =
                              '$selectedTime ${state.timeSlot[index]['timeslot_id']}';
                          widget.onTimeSelected(tmp);
                        });
                      }
                    },
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: timeSlotsStatus[index] == false
                            ? ColorPalette.lightBlue
                            : timeSlots.indexOf(selectedTime) == index
                                ? ColorPalette.deepBlue
                                : ColorPalette.mediumBlue,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          timeSlots[index],
                          style: TextStyle(
                              color: timeSlotsStatus[index] == false
                                  ? ColorPalette.mediumBlue
                                  : timeSlots.indexOf(selectedTime) == index
                                      ? ColorPalette.whiteColor
                                      : ColorPalette.blackColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      } else if (state is GetTimeSlotError) {
        return Center(
          child: Text(state.error),
        );
      }
      return const SizedBox.shrink();
    });
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
        return Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            AppBar().preferredSize.height,
            0,
            MediaQuery.of(context).size.height * 0.01,
          ),
          child: SizedBox(
            height: 40,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.8),
                ),
                color: ColorPalette.deepBlue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Center(
                    child: Text(
                      '${state.doctorInfo[0]['first_name']} ${state.doctorInfo[0]['last_name']}',
                      style: TextStyle(
                          fontSize: 14, color: ColorPalette.whiteColor),
                    ),
                  ),
                )),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
