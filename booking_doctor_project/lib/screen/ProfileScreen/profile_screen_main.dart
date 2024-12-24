import 'dart:io';
import 'dart:math';

import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_event.dart';
import 'package:booking_doctor_project/bloc/patient/ProfileInfo/profile_info_state.dart';
import 'package:booking_doctor_project/bloc/patient/UpdateProfile/update_profile_bloc.dart';
import 'package:booking_doctor_project/bloc/patient/UpdateProfile/update_profile_event.dart';
import 'package:booking_doctor_project/bloc/patient/UpdateProfile/update_profile_state.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/class/patient_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:flutter/material.dart';
import 'package:booking_doctor_project/screen/ProfileScreen/edit_profile_screen.dart';
import 'package:booking_doctor_project/screen/ProfileScreen/policy_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<PatientProfile?> patientProfile;

  @override
  void initState() {
    super.initState();
    patientProfile = PatientProfile.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GetProfileInfoBloc>();
    bloc.add(GetProfileInfoEvent(profileId: GlobalProfile().profileId!));
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: BlocBuilder<GetProfileInfoBloc, GetProfileInfoState>(
        builder: (context, state) {
          if (state is GetProfileInfoLoading) {
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
          } else if (state is GetProfileInfoSuccess) {
            return Column(
              children: [
                const SizedBox(height: 40),
                Text('Profile',
                    style:
                        TextStyle(fontSize: 28, color: ColorPalette.deepBlue)),
                Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: Image.network(state.profileInfo[0]
                                              ['ava_url'] !=
                                          ''
                                      ? state.profileInfo[0]['ava_url']
                                      : 'https://vikaxjhrmnewkrlovxmi.supabase.co/storage/v1/object/public/web/default_avatar.png')
                                  .image)),
                    ),
                    BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                      listener: (context, state) {
                        if (state is UpdateProfileSuccess) {
                          context.read<GetProfileInfoBloc>().add(
                              GetProfileInfoEvent(
                                  profileId: GlobalProfile().profileId!));
                        }
                      },
                      builder: (context, state) {
                        return Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 34,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.deepBlue),
                            child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: ColorPalette.whiteColor,
                                    size: 18,
                                  ),
                                  onPressed: () async {
                                    try {
                                      final ImagePicker picker = ImagePicker();
                                      final SupabaseClient supabase =
                                          Supabase.instance.client;
                                      // Pick an image from the gallery
                                      final XFile? pickedFile =
                                          await picker.pickImage(
                                              source: ImageSource.gallery);

                                      if (pickedFile == null) {
                                        return;
                                      }

                                      File imageFile = File(pickedFile.path);

                                      // Prepare file upload details
                                      final String fileName =
                                          '${GlobalProfile().profileId}/${generateRandomString(12)}.png';
                                      const String bucketName = "patient";

                                      final String folderPath =
                                          '${GlobalProfile().profileId}';
                                      final List<FileObject> objects =
                                          await supabase.storage
                                              .from(bucketName)
                                              .list(path: folderPath);

                                      if (objects.isNotEmpty) {
                                        final filePaths = objects
                                            .map((file) =>
                                                '$folderPath/${file.name}')
                                            .toList();
                                        await supabase.storage
                                            .from(bucketName)
                                            .remove(filePaths);
                                      }

                                      await supabase.storage
                                          .from(bucketName)
                                          .upload(
                                            fileName,
                                            imageFile,
                                            fileOptions: const FileOptions(
                                                cacheControl: '3600',
                                                upsert: false),
                                          );

                                      String publicUrl = supabase.storage
                                          .from(bucketName)
                                          .getPublicUrl(fileName);

                                      context.read<UpdateProfileBloc>().add(
                                          UpdateProfileImageEvent(
                                              id: GlobalProfile().profileId!,
                                              imageUrl: publicUrl));
                                    } catch (error) {
                                      print("Error: $error");
                                    }
                                  }),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 32),
                _buildMenuOptions(MediaQuery.of(context).size),
              ],
            );
          } else if (state is GetProfileInfoError) {
            return Center(
              child: Text(state.error),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }

  Widget _buildMenuOptions(Size size) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => profileInfoLayoutEvent(context),
            child: _profileInfoLayout(),
          ),
          SizedBox(height: size.height * 0.02),
          GestureDetector(
            onTap: () => policyLayoutEvent(context),
            child: _policyLayout(size),
          ),
          SizedBox(height: size.height * 0.02),
          GestureDetector(
            onTap: () => switchProfileLayoutEvent(context),
            child: _switchProfileLayout(),
          ),
          SizedBox(height: size.height * 0.02),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Container(
                          width: 300,
                          height: 150,
                          decoration: BoxDecoration(
                              color: ColorPalette.whiteColor,
                              borderRadius: BorderRadius.circular(40)),
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  'Logged Out',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.deepBlue,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Are you sure you want to log out?',
                                  style: TextStyle(
                                    color: ColorPalette.deepBlue,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const SizedBox(width: 32),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorPalette.lightBlue),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            color: ColorPalette.deepBlue),
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorPalette.deepBlue),
                                      onPressed: () {
                                        NavigationServices(context)
                                            .pushLogInScreen();
                                      },
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                            color: ColorPalette.whiteColor),
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                  });
            },
            child: _logoutLayout(),
          ),
        ],
      ),
    );
  }

  //Profile Info Layout
  Widget _profileInfoLayout() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Image.asset('assets/images/profile_info.png', fit: BoxFit.none),
      const SizedBox(width: 32), //Spacing
      const Text("Edit Profile",
          style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
      const Spacer(),
      Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none))
    ]);
  }

  void profileInfoLayoutEvent(BuildContext context) {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        ));
  }

  // Policy Layout
  Widget _policyLayout(Size size) {
    return Row(children: [
      Image.asset('assets/images/privacy_policy.png', fit: BoxFit.none),
      const SizedBox(width: 32), //Spacing
      const Text("Private Policy",
          style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
      const Spacer(),
      Padding(
          padding: EdgeInsets.only(right: size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none))
    ]);
  }

  void policyLayoutEvent(BuildContext context) {
    // Handle on tap event here.
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const PolicyScreen()));
  }

  void helpLayoutEvent() {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
    debugPrint("Help Layout clicked");
  }

  //Switch profile Layout
  Widget _switchProfileLayout() {
    return Row(children: [
      Image.asset('assets/images/switches.png', fit: BoxFit.none),
      const SizedBox(width: 32), //Spacing
      const Text("Switch Profile",
          style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
      const Spacer(),
      Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none))
    ]);
  }

  void switchProfileLayoutEvent(BuildContext context) {
    // Handle on tap event here.
    NavigationServices(context).pushChooseProfileScreen();
  }

  // Logout Layout
  Widget _logoutLayout() {
    return Row(children: [
      Image.asset('assets/images/logout.png', fit: BoxFit.none),
      const SizedBox(width: 32), //Spacing
      const Text("Logout",
          style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
      const Spacer(),
      Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none))
    ]);
  }
}
