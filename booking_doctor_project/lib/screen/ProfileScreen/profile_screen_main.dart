import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:booking_doctor_project/screen/ProfileScreen/edit_profile_screen.dart';
import 'package:booking_doctor_project/screen/ProfileScreen/policy_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteColor,
      body: Column(
        children: [
          const CommonAppBarView(
              iconData: Icons.arrow_back_ios, title: 'Profile'),

          Stack(children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: Image.asset(
                    'assets/images/patient/default_avatar.png',
                  ).image)),
            ),
            Positioned(right: 0, bottom: 0, child: _editButton())
          ]),

          // Name
          const Text(
            'name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),

          _buildMenuOptions(MediaQuery.of(context).size),
        ],
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
                                      onPressed: () {},
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

  // Back button
  Widget _backButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.038,
        vertical: MediaQuery.of(context).size.height * 0.061,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  // Edit button
  Widget _editButton() {
    return Container(
      width: 34,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: ColorPalette.deepBlue),
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.edit,
            color: ColorPalette.whiteColor,
            size: 18,
          ),
          onPressed: () => editButtonEvent(),
        ),
      ),
    );
  }

  void editButtonEvent() {
    // Handle edit button click event here.
    //TO-DO IMPLEMENT
    debugPrint("Edit button clicked");
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
