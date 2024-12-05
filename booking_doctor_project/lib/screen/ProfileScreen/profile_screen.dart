import 'package:flutter/material.dart';
import 'dart:developer';

//Width = 360
//height = 800

//Test phone
//Width = 392.7272
//Height = 783.2727

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        backButton(),

        // My Profile
        Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.373,
            MediaQuery.of(context).size.height * 0.07,
            0,
            0,
          ),
          child: 
            const Text(
              "My Profile",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF2260FF), fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),

        // ImageProfile and EditIcon
        Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.373,
            MediaQuery.of(context).size.height * 0.13321,
            0,
            0,
          ),
          child: 
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/test_profile_image.png',
                  fit:BoxFit.none
                ),

                // Edit icon
                Positioned(
                  bottom: -MediaQuery.of(context).size.height * 0.013,
                  right: -MediaQuery.of(context).size.width * 0.021,
                  child: editButton()
                )
              ],
            )
        ),

        // Name
        Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.373,
            MediaQuery.of(context).size.height * 0.28,
            0,
            0,
          ),
          child: const Text(
            'John Doe',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ),

        // Profile Info, Policy, Help, Switch Profile, Logout
        Padding(
          padding:EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.08333,
            MediaQuery.of(context).size.height * 0.37,
            0,
            0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap:() => profileInfoLayoutEvent(),
                child: profileInfoLayout()
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              GestureDetector(
                onTap: () => policyLayoutEvent(),
                child: policyLayout()
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              GestureDetector(
                onTap: () => helpLayoutEvent(),
                child: helpLayout()
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              GestureDetector(
                onTap: () => switchProfileLayoutEvent(),
                child: switchProfileLayout()
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

              GestureDetector(
                onTap: () => logoutLayoutEvent(),
                child: logoutLayout()
              ),
            ],
          )
        )
      ],
    ));
  }

  // Back button
  Widget backButton() {
  return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03889,
            vertical: MediaQuery.of(context).size.height * 0.06125,
          ),
          child: IconButton(
            icon: Image.asset(
              'assets/images/back_icon.png', 
              fit: BoxFit.none),
            onPressed: () => backButtonEvent(),
          )
        );
  }

  void backButtonEvent() {
    // Handle back button click event here.
    //TO-DO IMPLEMENT
    debugPrint("Back button clicked");
  }

  //Edit button
  Widget editButton() {
    return IconButton(
      icon: Image.asset(
        'assets/images/edit_icon.png', 
        fit: BoxFit.none),
      onPressed: () => editButtonEvent(),
    );
  }

  void editButtonEvent() {
    // Handle edit button click event here.
    //TO-DO IMPLEMENT
    debugPrint("Edit button clicked");
  }

  //Profile Info Layout
  Widget profileInfoLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/images/profile_info.png', fit: BoxFit.none),
        SizedBox(width: MediaQuery.of(context).size.width * 0.07778,), //Spacing
        const Text("Profile Info", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void profileInfoLayoutEvent() {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
    debugPrint("Profile Info layout clicked");
  }

  //Policy Layout
  Widget policyLayout() {
    return Row(
      children: [
        Image.asset('assets/images/privacy_policy.png', fit: BoxFit.none),
        SizedBox(width: MediaQuery.of(context).size.width * 0.07778,), //Spacing
        const Text("Private Policy", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void policyLayoutEvent() {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
    debugPrint("Policy layout clicked");
  }

  //Help Layout
  Widget helpLayout() {
    return Row(
      children: [
        Image.asset('assets/images/help_icon.png', fit: BoxFit.none),
        SizedBox(width: MediaQuery.of(context).size.width * 0.07778,), //Spacing
        const Text("Help", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void helpLayoutEvent() {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
    debugPrint("Help Layout clicked");
  }

  //Switch profile Layout
  Widget switchProfileLayout() {
    return Row(
      children: [
        Image.asset('assets/images/switches.png', fit: BoxFit.none),
        SizedBox(width: MediaQuery.of(context).size.width * 0.07778,), //Spacing
        const Text("Switch Profile", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void switchProfileLayoutEvent() {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
    debugPrint("Switch Profile Layout clicked");
  }

  //Logout Layout
  Widget logoutLayout() {
    return Row(
      children: [
        Image.asset('assets/images/logout.png', fit: BoxFit.none),
        SizedBox(width: MediaQuery.of(context).size.width * 0.07778,), //Spacing
        const Text("Switch Profile", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void logoutLayoutEvent() {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
    debugPrint("Logout Layout clicked");
  }
}