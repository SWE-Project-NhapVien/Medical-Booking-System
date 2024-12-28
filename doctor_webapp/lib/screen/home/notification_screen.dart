import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:doctor_webapp/widgets/common_app_bar_view.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        children: [
          CommonAppBarView(
            iconData: Icons.arrow_back_ios,
            title: "Notification",
            onBackClick: () => Navigator.pop(context),
            isWeb: true,
          ),
          const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //     child: Expanded(
          //       child: Card(
          //         color: ColorPalette.deepBlue,
          //         shape: const RoundedRectangleBorder(
          //           borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
          //         ),
          //         child: const SingleChildScrollView(
          //           child: Column(
          //             children: [
          //               Text("Hi")
          //             ],
          //           ),
          //       ),
          //                   ),
          //     )
          // )
        ],
      )
    );
  }
}