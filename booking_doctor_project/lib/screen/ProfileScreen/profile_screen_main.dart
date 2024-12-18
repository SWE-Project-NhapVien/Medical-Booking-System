import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:booking_doctor_project/screen/ProfileScreen/edit_profile_screen.dart';
import 'package:booking_doctor_project/screen/ProfileScreen/policy_screen.dart';

// Replace this with your actual global patient ID source
String globalPatientId = "ef48f364-1e9a-4c86-b490-57883ffcbc59";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showLogoutCard = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleLogoutCard() {
    setState(() {
      _showLogoutCard = !_showLogoutCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          // Profile Info, Policy, Switch Profile, Logout
          _buildMenuOptions(MediaQuery.of(context).size),
          const Spacer(),
          if (_showLogoutCard) _buildLogoutOverlay(),
        ],
      ),
    );
  }

  Widget _buildLogoutOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.whiteColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.blackColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Logout',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2260FF)),
            ),
            const SizedBox(height: 10),
            const Text('Are you sure you want to log out?'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFFCAD6FF)),
                  ),
                  onPressed: _toggleLogoutCard,
                  child: Text('Cancel',
                      style: TextStyle(
                          color: ColorPalette.deepBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF2260FF)),
                  ),
                  onPressed: () => logoutCardEvent(),
                  child: Text('Yes, Logout',
                      style: TextStyle(
                          color: ColorPalette.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
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
            onTap: () => logoutLayoutEvent(),
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
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Switch Profile")));
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

  void logoutLayoutEvent() {
    _toggleLogoutCard();
  }

  void logoutCardEvent() {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
  }
}
