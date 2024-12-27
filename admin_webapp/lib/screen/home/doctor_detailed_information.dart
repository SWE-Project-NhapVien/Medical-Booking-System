import 'package:admin_webapp/bloc/GetDoctorSchedule/get_doctor_schedule_bloc.dart';
import 'package:admin_webapp/class/doctor_schedule.dart';
import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/localfiles.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:admin_webapp/widgets/common_button.dart';
import 'package:admin_webapp/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

// ignore: must_be_immutable
class DoctorDetailedInformation extends StatefulWidget {
  DoctorDetailedInformation({
    super.key,
    required this.doctorID,
    required this.fullname,
    this.avaUrl = '',
    required this.specialization,
  });

  final String doctorID;
  final String fullname;
  String avaUrl;
  final List<String> specialization;

  @override
  State<DoctorDetailedInformation> createState() =>
      _DoctorDetailedInformationState();
}

class _DoctorDetailedInformationState extends State<DoctorDetailedInformation> {
  List<DoctorSchedule>? schedule;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    context
        .read<GetDoctorScheduleBloc>()
        .add(GetDoctorScheduleRequired(doctorID: widget.doctorID));
  }

  Map<DateTime, List<NeatCleanCalendarEvent>> mapDoctorScheduleToCalendarEvents(
      List<DoctorSchedule> schedule) {
    final Map<DateTime, List<NeatCleanCalendarEvent>> calendarEvents = {};

    for (var item in schedule) {
      final date = item.timeslotDate;
      final timeParts = item.timeslotTime.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      final eventDate = DateTime(date.year, date.month, date.day);
      final event = NeatCleanCalendarEvent(
        item.timeslotStatus ? 'Available' : 'Unavailable',
        startTime: DateTime(date.year, date.month, date.day, hour, minute),
        endTime: DateTime(date.year, date.month, date.day, hour, minute)
            .add(const Duration(minutes: 30)),
        description: '',
        color: item.timeslotStatus ? Colors.green : Colors.red,
        isDone: !item.timeslotStatus,
      );

      calendarEvents.putIfAbsent(eventDate, () => []).add(event);
    }

    return calendarEvents;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<GetDoctorScheduleBloc, GetDoctorScheduleState>(
      listener: (context, state) async {
        if (state is GetDoctorScheduleLoading) {
          Dialogs(context).showLoadingDialog();
        } else if (state is GetDoctorScheduleSuccess) {
          Navigator.of(context).pop();
          setState(() {
            schedule = state.scheduleList;
          });
        } else if (state is GetDoctorScheduleFailure) {
          Navigator.of(context).pop();
          Dialogs(context).showErrorDialog(message: state.error);
        }
      },
      child: Container(
        width: size.width * 0.3,
        margin: EdgeInsets.only(right: size.width * 0.01),
        decoration: BoxDecoration(
          color: ColorPalette.deepBlue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: Column(
            children: [
              CircleAvatar(
                radius: size.width * 0.035,
                backgroundImage: widget.avaUrl.isNotEmpty
                    ? NetworkImage(widget.avaUrl)
                    : const AssetImage(Localfiles.defaultProfilePicture),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                widget.fullname,
                style: TextStyles(context).getRegularStyle(
                    size: 24,
                    color: ColorPalette.whiteColor,
                    fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.025,
                      vertical: size.height * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.01),
                    child: Center(
                      child: Calendar(
                          startOnMonday: true,
                          weekDays: const [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ],
                          displayMonthTextStyle: TextStyles(context)
                              .getRegularStyle(
                                  size: 18,
                                  color: ColorPalette.deepBlue,
                                  fontWeight: FontWeight.w400),
                          eventDoneColor: ColorPalette.redColor,
                          selectedColor: ColorPalette.deepBlue,
                          todayColor: ColorPalette.deepBlue,
                          eventColor: ColorPalette.redColor,
                          todayButtonText: 'Today',
                          locale: 'en_EN',
                          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                          datePickerType: DatePickerType.date,
                          isExpanded: true,
                          bottomBarColor: ColorPalette.proportionAmber,
                          showEventListViewIcon: true,
                          eventTileHeight: 65,
                          eventsList:
                              mapDoctorScheduleToCalendarEvents(schedule ?? [])
                                  .values
                                  .expand((events) => events)
                                  .toList(),
                          onEventSelected: (event) {
                            //
                          },
                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.025,
                    vertical: size.height * 0.005),
                child: CommonButton(
                    onTap: () async {
                      await Dialogs(context).showEditScheduleDialog(
                          size, widget.doctorID, selectedDate!);
                    },
                    buttonTextWidget: Text('Edit Schedule',
                        style: TextStyles(context).getRegularStyle(
                          size: 20,
                          color: ColorPalette.deepBlue,
                        )),
                    backgroundColor: ColorPalette.whiteColor,
                    radius: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
