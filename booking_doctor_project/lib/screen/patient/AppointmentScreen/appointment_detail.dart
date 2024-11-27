import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:flutter/material.dart';

import '../../../widgets/common_app_bar_view.dart';
import '../../../widgets/comon_button.dart';

class AppointmentDetail extends StatefulWidget {
  const AppointmentDetail({super.key});

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  @override
  void initState() {
    // Call BLoC to fetch data here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar
          CommonAppBarView(
            iconData: Icons.arrow_back_ios,
            title: "Appointment Detail",
            onBackClick: () {
              Navigator.pop(context);
            },
          ),
          // Appointment Details
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(context, 'Time'),
                _sectionContent(context, 'Fetched Data Here'),
                _divider(context),
                _sectionTitle(context, 'Patient Details'),
                _informationBox(context, title: 'Name', info: 'Nguyen Van A'),
                _informationBox(context, title: 'Age', info: '18'),
                _informationBox(context, title: 'Gender', info: 'Male'),
                _divider(context),
                _sectionTitle(context, 'Appointment Notes'),
                _appointmentNote(
                  context,
                  note: 'This is the note fetched from data.',
                ),
                const SizedBox(height: 22),
                // Cancel Button
                CommonButton(
                  buttonText: 'Cancel',
                  fontSize: 18,
                  backgroundColor: ColorPalette.redColor,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget for section titles
  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyles(context).getBoldStyle(color: ColorPalette.deepBlue),
    );
  }

  // Widget for section content
  Widget _sectionContent(BuildContext context, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        content,
        style: TextStyles(context).getRegularStyle(),
      ),
    );
  }

  // Divider widget
  Widget _divider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Divider(color: ColorPalette.deepBlue)),
    );
  }

  // Widget for displaying information (e.g., name, age, etc.)
  Widget _informationBox(BuildContext context,
      {required String title, required String info}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles(context).getRegularStyle(fontSize: 12),
        ),
        const SizedBox(height: 6),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
            color: ColorPalette.lightBlue,
          ),
          child: Text(
            info,
            style: TextStyles(context).getRegularStyle(
                fontSize: 12,
                color: const Color(0xFF809CFF)), // đưa color này vào themes nhé
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  // Widget for appointment notes
  Widget _appointmentNote(BuildContext context, {required String note}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: ColorPalette.mediumBlue),
      ),
      child: Text(
        note,
        style: TextStyles(context).getRegularStyle(fontSize: 12),
      ),
    );
  }
}
