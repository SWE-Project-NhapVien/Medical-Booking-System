import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:booking_doctor_project/widgets/textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'choose_date.dart';

import '../../../utils/color_palette.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/common_appbar_with_title.dart';
import '../../../widgets/common_button.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final Color? backgroundColor = ColorPalette.deepBlue;
  DateTime? selectedDate;
  String? selectedMonth;

  final fullNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
        child: SingleChildScrollView(
          child: Column(children: [
            Row (children: [
              CommonAppBarWithTitle(
                title: "",
                topPadding: MediaQuery.of(context).padding.top,
                prefixIconData: Icons.arrow_back_ios_new_rounded,
                onPrefixIconClick: () async {
                  await Dialogs(context).showErrorDialog(
                    title: "Appointment Discard",
                    message: "This appointment will be discarded"
                  );
                  // Navigate to previous screen here
                  Navigator.pop(context);
                },
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.8),
                  ),
                  color: backgroundColor ?? Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      "Dr. Olivia Turner, M.D.",
                      style: TextStyle(fontFamily: "League Spartan", fontSize: 14, color: ColorPalette.whiteColor),
                    ),
                  )
                ),
              )
            ],),

            //Content here
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.22,
              child: HorizontalCalendar(
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
                onMonthSelected: (month) {
                  setState(() {
                    selectedMonth = month;
                  });
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: 8,
                right: 8
              ),
              child: Divider(
                color: ColorPalette.deepBlue,
                thickness: 1.0,
                height: 1.0,
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: 20
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                  child: Text(
                    "Patient Detail",
                    style: TextStyle(color: ColorPalette.deepBlue, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
              child: LabelAndTextField(
                context: context, 
                label: "Full Name", 
                hintText: "", 
                controller: fullNameController,  
                errorText: ""
              ),
            ),

            LabelAndTextField(
              context: context, 
              label: "Age", 
              hintText: "", 
              controller: ageController,   
              errorText: ""
            ),

            Align(
              alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Gender",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ColorPalette.blackColor),
                  ),
                )
            ),

            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.8),
                  ),
                  color: backgroundColor ?? Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      "Female",
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: ColorPalette.whiteColor),
                    ),
                  )
                ),
              )
            ),

            Align(
              alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, top: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    "Describe your problem",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ColorPalette.blackColor),
                  ),
                )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CommonButton(
                  buttonTextWidget: Text(
                    "Book",
                    style: TextStyles(context).getTitleStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            )

          ])
        )
      )
    );
  }
}