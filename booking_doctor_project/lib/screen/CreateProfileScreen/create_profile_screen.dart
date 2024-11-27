import 'package:booking_doctor_project/utils/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/common_appbar_with_title.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                CommonAppBarWithTitle(
                  title: 'Create A Profile',
                  titleSize: 32,
                  topPadding: MediaQuery.of(context).padding.top,
                  prefixIconData: Icons.arrow_back_ios_new_rounded,
                  onPrefixIconClick: () {
                    Navigator.pop(context);
                  },
                ),
          ])
      )
    );
  }
}
