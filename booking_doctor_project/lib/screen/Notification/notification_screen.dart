import 'package:booking_doctor_project/bloc/Appointment/Notification/notification_bloc.dart';
import 'package:booking_doctor_project/bloc/Appointment/Notification/notification_event.dart';
import 'package:booking_doctor_project/bloc/Appointment/Notification/notification_state.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatefulWidget {
  final List<String> notiId;
  const NotificationScreen({super.key, required this.notiId});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetNotificationDataBloc(),
      child: Scaffold(
        body: Column(
          children: [
            CommonAppBarView(
              iconData: Icons.arrow_back_ios,
              title: "Notifications",
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<GetNotificationDataBloc, GetNotificationState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<GetNotificationDataBloc>().add(
                            UpdateNotificationStatusEvent(
                                notiIdList: widget.notiId));
                      },
                      child: Text(
                        "Mark all as read",
                        style: TextStyle(
                            color: ColorPalette.deepBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: NotificationsView(notiIdList: widget.notiId),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsView extends StatelessWidget {
  final List<String> notiIdList;
  const NotificationsView({super.key, required this.notiIdList});

  @override
  Widget build(BuildContext context) {
    context
        .read<GetNotificationDataBloc>()
        .add(GetNotificationDataEvent(notiIdList: notiIdList));

    return BlocBuilder<GetNotificationDataBloc, GetNotificationState>(
      builder: (context, state) {
        if (state is GetNotificationLoading) {
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
        } else if (state is GetNotificationSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.notificationList.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  color: state.notificationList[index]['read_status'] == true
                      ? Colors.transparent
                      : ColorPalette.mediumBlue,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: ColorPalette.deepBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 32.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.notificationList[index]['title'],
                                    style: TextStyle(
                                        color: ColorPalette.deepBlue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    state.notificationList[index]['time']
                                        .substring(0, 16)
                                        .replaceAll("T", " "),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                state.notificationList[index]['content'],
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is GetNotificationError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
