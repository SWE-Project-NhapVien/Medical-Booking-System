// import 'package:booking_doctor_project/utils/color_palette.dart';
// import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
// import 'package:flutter/material.dart';

// class NotificationScreen extends StatefulWidget {
//   final List notiId;
//   const NotificationScreen({super.key, required this.notiId});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           CommonAppBarView(
//             iconData: Icons.arrow_back_ios,
//             title: "Notifications",
//             onBackClick: () {
//               Navigator.pop(context);
//             },
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: [
//               const Spacer(),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     for (int i = 0; i < widget.notiList.length; i++) {
//                       widget.notiList[i][3] = true;
//                     }
//                   });
//                 },
//                 child: Text(
//                   "Mark all as read",
//                   style: TextStyle(
//                       color: ColorPalette.deepBlue,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height - 200,
//             child: ListView.builder(
//               padding: EdgeInsets.zero,
//               itemCount: widget.notiList.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   height: 100,
//                   color: widget.notiList[index][3] == true
//                       ? Colors.transparent
//                       : ColorPalette.mediumBlue,
//                   child: Row(
//                     children: [
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Container(
//                         width: 60.0, // Width of the button
//                         height:
//                             60.0, // Height of the button (same as width for circular shape)
//                         decoration: BoxDecoration(
//                           color: ColorPalette.deepBlue, // Blue background
//                           shape: BoxShape.circle, // Circular shape
//                         ),
//                         child: const Icon(
//                           Icons.calendar_month, // Magnifying glass icon
//                           color: Colors.white, // White color for the icon
//                           size: 32.0, // Icon size
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: SizedBox(
//                           height: 90,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     widget.notiList[index][0],
//                                     style: TextStyle(
//                                         color: ColorPalette.deepBlue,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   const Spacer(),
//                                   Text(
//                                     widget.notiList[index][2]
//                                         .substring(0, 16)
//                                         .replaceAll("T", " "),
//                                     style: const TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 widget.notiList[index][1],
//                                 overflow: TextOverflow.clip,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
