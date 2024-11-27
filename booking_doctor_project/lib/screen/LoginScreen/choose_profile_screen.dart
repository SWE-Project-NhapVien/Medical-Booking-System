import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/utils/themes.dart';
import 'package:booking_doctor_project/widgets/bottom_move_top_animation.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';
import '../../widgets/common_appbar_with_title.dart';

class ChooseProfileScreen extends StatefulWidget {
  const ChooseProfileScreen({super.key});

  @override
  State<ChooseProfileScreen> createState() => _ChooseProfileScreenState();
}

class _ChooseProfileScreenState extends State<ChooseProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonAppBarWithTitle(
                      title: 'Choose Your Profile',
                      titleSize: 32,
                      topPadding: MediaQuery.of(context).padding.top,
                      prefixIconData: Icons.arrow_back_ios_new_rounded,
                      onPrefixIconClick: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Your Family',
                      style: TextStyles(context).getTitleStyle(
                          size: 20,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.blueColor),
                    ),
                    const ProfileAccount(
                      profileName: 'Tran Phuong Anh',
                      profilePicture: Localfiles.defaultProfilePciture,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: ColorPalette.whiteColor,
                            child: Icon(
                              Icons.add,
                              size: 50,
                              color: ColorPalette.blueColor,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Text(
                            'Add Member',
                            style: TextStyles(context)
                                .getRegularStyle(color: ColorPalette.blueColor),
                          ),
                        ],
                      ),
                    )
                  ]))),
    );
  }
}

class ProfileAccount extends StatelessWidget {
  const ProfileAccount(
      {super.key, required this.profileName, required this.profilePicture});

  final String profilePicture;
  final String profileName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(profilePicture),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        Text(
          profileName,
          style: TextStyles(context)
              .getRegularStyle(color: ColorPalette.blueColor),
        ),
      ],
    );
  }
}
