import 'package:booking_doctor_project/bloc/patient/FetchProfile/fetch_profile_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/GetAProfile/get_a_profile_bloc.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:booking_doctor_project/widgets/tap_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void initState() {
    super.initState();
    context.read<FetchProfileBloc>().add(const FetchProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: MultiBlocListener(
        listeners: [
          BlocListener<FetchProfileBloc, FetchProfileState>(
            listener: (context, state) {
              if (state is FetchProfileSuccess) {
                setState(() {
                  profiles = state.profiles;
                });
              } else if (state is FetchProfileError) {
                Dialogs(context).showErrorDialog(message: state.error);
              }
            },
          ),
          BlocListener<GetAProfileBloc, GetAProfileState>(
            listener: (context, state) {
              if (state is GetAProfileSuccess) {
                NavigationServices(context).pushHomeScreen();
              } else if (state is GetAProfileError) {
                Dialogs(context).showErrorDialog(message: state.error);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profiles.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              TapEffect(
                                onClick: () {
                                  final selectedProfileId =
                                      profiles[index]['profile_id'];
                                  GlobalProfile().profileId = selectedProfileId;
                                  context.read<GetAProfileBloc>().add(
                                      GetAProfileRequired(
                                          profileId: selectedProfileId));
                                },
                                child: ProfileAccount(
                                  profileName: profiles[index]['last_name'] +
                                      " " +
                                      profiles[index]['first_name'],
                                  profilePicture: profiles[index]['ava_url'] ??
                                      Localfiles.defaultProfilePicture,
                                  isDefaultImage:
                                      profiles[index]['ava_url'] == null,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationServices(context)
                              .pushCompleteProfileScreen();
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
                              style: TextStyles(context).getRegularStyle(
                                  color: ColorPalette.deepBlue),
                            ),
                          ],
                        ),
                      ),
                    ]))),
      ),
    );
  }
}

class ProfileAccount extends StatelessWidget {
  const ProfileAccount(
      {super.key,
      required this.profileName,
      required this.profilePicture,
      required this.isDefaultImage});

  final String profilePicture;
  final String profileName;
  final bool isDefaultImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: isDefaultImage
                  ? AssetImage(profilePicture)
                  : NetworkImage(profilePicture),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        Text(
          profileName,
          style: TextStyles(context).getTitleStyle(
              fontWeight: FontWeight.w500, color: ColorPalette.deepBlue),
        ),
      ],
    );
  }
}
