import 'dart:convert';

import 'package:admin_webapp/bloc/UpdateDoctorSchedule/update_doctor_schedule_bloc.dart';
import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/localfiles.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:admin_webapp/widgets/common_button.dart';
import 'package:admin_webapp/widgets/tap_effect%20copy.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Dialogs {
  final BuildContext context;
  Dialogs(this.context);

  Future<dynamic> showLoadingDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        double lottieSize = MediaQuery.of(context).size.width * 0.2;
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset(
              Localfiles.loading,
              width: lottieSize,
            ));
      },
    );
  }

  Future<void> showErrorDialog(
      {String title = 'Error',
      required String message,
      String buttonText = 'Got it!'}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                title,
                style: TextStyles(context).getTitleStyle(
                    size: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.deepBlue),
              ),
              scrollable: true,
              backgroundColor: ColorPalette.blueFormColor,
              content: SingleChildScrollView(
                child: Text(
                  message,
                  style: TextStyles(context)
                      .getRegularStyle(color: ColorPalette.redColor),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      buttonText,
                      style: TextStyles(context).getTitleStyle(
                        size: 18,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.blackColor,
                      ),
                    ))
              ]);
        });
  }

  Future<void> showAnimatedDialog(
      {required String title, required String content}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (content, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                backgroundColor: ColorPalette.blueFormColor,
                title: Text(
                  title,
                  style: TextStyles(context).getTitleStyle(
                      size: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.deepBlue),
                ),
                content: Text(
                  content,
                  style: TextStyles(context)
                      .getRegularStyle(color: ColorPalette.deepBlue)
                      .copyWith(fontStyle: FontStyle.italic),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none),
              ),
            ),
          );
        });
  }

  Future<void> showLogoutDialog(BuildContext context, VoidCallback onConfirm) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (content, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                  backgroundColor: ColorPalette.blueFormColor,
                  title: Text(
                    'Logout',
                    style: TextStyles(context).getTitleStyle(
                        size: 18,
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.deepBlue),
                  ),
                  content: Text(
                    'Are you sure you want to logout?',
                    style: TextStyles(context)
                        .getRegularStyle(color: ColorPalette.deepBlue)
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        child: Text(
                          'Logout',
                          style: TextStyles(context).getTitleStyle(
                            size: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.blackColor,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyles(context).getTitleStyle(
                            size: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.blackColor,
                          ),
                        ))
                  ]),
            ),
          );
        });
  }

  Future<void> showEditScheduleDialog(Size size, String doctorID,
      DateTime selectedDate) {
    List<String> timeSlots = [
      '09:00',
      '09:30',
      '10:00',
      '10:30',
      '11:00',
      '11:30',
      '12:00',
      '12:30',
      '13:00',
      '13:30',
      '14:00',
      '14:30',
      '15:00',
      '15:30',
      '16:00',
    ];

    Set<String> unavailableTimes = {};

    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (content, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: AlertDialog(
                backgroundColor: ColorPalette.blueFormColor,
                title: Text(
                  'Select Unavailable Time',
                  style: TextStyles(context).getTitleStyle(
                      size: 20,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.deepBlue),
                ),
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.4,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2.5,
                          ),
                          itemCount: timeSlots.length,
                          itemBuilder: (context, index) {
                            final time = timeSlots[index];
                            final isSelected = unavailableTimes.contains(time);
                            return TapEffect(
                                onClick: () {
                                  setState(() {
                                    if (isSelected) {
                                      unavailableTimes.remove(time);
                                    } else {
                                      unavailableTimes.add(time);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorPalette.lightdeepBlue
                                        : ColorPalette.deepBlue,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      time,
                                      style:
                                          TextStyles(context).getRegularStyle(
                                        size: 18,
                                        color: isSelected
                                            ? ColorPalette.deepBlue
                                            : ColorPalette.whiteColor,
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                    );
                  },
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        List<Map<String, dynamic>> timeslots =
                            timeSlots.map((time) {
                          String convertedTime = convertToFullTime(time);
                          return {
                            "status": unavailableTimes.contains(time)
                                ? "false"
                                : "true",
                            "time": convertedTime,
                            "date": formatDate(selectedDate),
                          };
                        }).toList();
                        String timeslotsJson = jsonEncode(timeslots);
                        print('timeslotsJson: $timeslotsJson');
                        context.read<UpdateDoctorScheduleBloc>().add(
                            UpdateDoctorScheduleRequired(
                                doctorID: doctorID, timeSlotJson: timeslots));
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.lightdeepBlue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Save',
                          style: TextStyles(context).getTitleStyle(
                            size: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.whiteColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel',
                          style: TextStyles(context).getTitleStyle(
                            size: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.deepBlue,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}

String convertToFullTime(String time) {
  return '$time:00';
}

String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }