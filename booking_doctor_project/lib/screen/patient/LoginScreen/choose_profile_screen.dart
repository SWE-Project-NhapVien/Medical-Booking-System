import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/patient/patient_localfiles.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/color_palette.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/common_appbar_with_title.dart';

class ChooseProfileScreen extends StatefulWidget {
  const ChooseProfileScreen({super.key});

  @override
  State<ChooseProfileScreen> createState() => _ChooseProfileScreenState();
}

class _ChooseProfileScreenState extends State<ChooseProfileScreen> {
  List<Map<String, dynamic>> profiles = [];
  bool isLoading = true;

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
                          color: ColorPalette.deepBlue),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profiles.length,
                      itemBuilder: (context, index) {
                        return ProfileAccount(
                          profileName: profiles[index]['p_last_name'] + profiles[index]['p_first_name'],
                          profilePicture: PatientLocalfiles.defaultProfilePicture,
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationServices(context).pushCompleteProfileScreen();
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: ColorPalette.whiteColor,
                            child: Icon(
                              Icons.add,
                              size: 50,
                              color: ColorPalette.deepBlue,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Text(
                            'Add Member',
                            style: TextStyles(context)
                                .getRegularStyle(color: ColorPalette.deepBlue),
                          ),
                        ],
                      ),
                    ),
                  ]))),
    );
  }

  Future<void> fetchProfiles() async {
    try {
      final response = await Supabase.instance.client
          .rpc('read_patient_profiles_by_patient_account');

      if (response.error != null) {
        throw response.error!;
      }

      setState(() {
        profiles = List<Map<String, dynamic>>.from(response.data);
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Dialogs(context).showErrorDialog(message: e.toString());
    }
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
              .getRegularStyle(color: ColorPalette.deepBlue),
        ),
      ],
    );
  }
}
