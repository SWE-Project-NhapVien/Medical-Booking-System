import 'package:booking_doctor_project/screen/ProfileScreen/policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:booking_doctor_project/screen/ProfileScreen/edit_profile_screen.dart';

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
  bool _showLogoutCard = false;

  void _toggleLogoutCard() {
    setState(() {
      _showLogoutCard = !_showLogoutCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
      children: [
        _backButton(context),

        // My Profile
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.07
            ),
            child: 
              const Text(
                "My Profile",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF2260FF), fontWeight: FontWeight.bold, fontSize: 24),
              )
            )
        ),

        // ImageProfile and EditIcon
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.13321
          ),
          child: 
            Stack(
              children: [
                Image.asset(
                  'assets/images/test_profile_image.png',
                  fit:BoxFit.none
                ),

                // Edit icon
                Positioned(
                  bottom: -size.height*0.009,
                  right: -size.width*0.005,
                  child: _editButton()
                )
              ]
            )
          )
        ),

        // Name
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.28
            ),
            child: const Text(
              'John Doe',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )
          )
        ),  

        // Profile Info, Policy, Help, Switch Profile, Logout
        Padding(
          padding:EdgeInsets.fromLTRB(
            size.width * 0.08333,
            size.height * 0.37,
            0,
            0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap:() => profileInfoLayoutEvent(context),
                child: _profileInfoLayout()
              ),

              SizedBox(height: size.height * 0.02,),

              GestureDetector(
                onTap: () => policyLayoutEvent(context),
                child: _policyLayout(size)
              ),

              SizedBox(height: size.height * 0.02,),

              GestureDetector(
                onTap: () => switchProfileLayoutEvent(context),
                child: _switchProfileLayout()
              ),

              SizedBox(height: size.height * 0.02,),

              GestureDetector(
                onTap: () => logoutLayoutEvent(),
                child: _logoutLayout()
              ),
            ],
          )
        ),
      
        if (_showLogoutCard) 
          GestureDetector(
            onTap: _toggleLogoutCard, // Dismiss card on tap outside
            child: Container(
              color: const Color.fromARGB(255, 34, 96, 255).withOpacity(0.54), // Background overlay
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _logoutCard(size)
              ),
            ),
          ),
      ],
    ));
  }

  // Back button
  Widget _backButton(BuildContext context) {
  return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03889,
            vertical: MediaQuery.of(context).size.height * 0.06125,
          ),
          child: IconButton(
            icon: Image.asset(
              'assets/images/back_icon.png', 
              fit: BoxFit.none),
            onPressed: () => backButtonEvent(context),
          )
        );
  }

  void backButtonEvent(BuildContext context) {
    // Handle back button click event here.
    //TO-DO IMPLEMENT
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Back button clicked")));
  }

  //Edit button
  Widget _editButton() {
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
  Widget _profileInfoLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/images/profile_info.png', fit: BoxFit.none),
        const SizedBox(width: 32), //Spacing
        const Text("Edit Profile", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void profileInfoLayoutEvent(BuildContext context) {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      )
    );
  }

  //Policy Layout
  Widget _policyLayout(Size size) {
    return Row(
      children: [
        Image.asset('assets/images/privacy_policy.png', fit: BoxFit.none),
        const SizedBox(width: 32), //Spacing
        const Text("Private Policy", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void policyLayoutEvent(BuildContext context) {
    // Handle on tap event here.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PolicyScreen())  
    );
  }

  //Help Layout
  Widget _helpLayout() {
    return Row(
      children: [
        Image.asset('assets/images/help_icon.png', fit: BoxFit.none),
        const SizedBox(width: 32), //Spacing
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
  Widget _switchProfileLayout() {
    return Row(
      children: [
        Image.asset('assets/images/switches.png', fit: BoxFit.none),
        const SizedBox(width: 32), //Spacing
        const Text("Switch Profile", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void switchProfileLayoutEvent(BuildContext context) {
    // Handle on tap event here.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Switch Profile")));
  }

  //Logout Layout
  Widget _logoutLayout() {
    return Row(
      children: [
        Image.asset('assets/images/logout.png', fit: BoxFit.none),
        const SizedBox(width: 32), //Spacing
        const Text("Logout", style: TextStyle(fontFamily: "League Spartan", fontSize: 20)),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.0861111),
          child: Image.asset('assets/images/next_arrow.png', fit: BoxFit.none)
        )
    ]);
  }

  void logoutLayoutEvent() {
    _toggleLogoutCard();
  }

  Widget _logoutCard(Size size) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Logout',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2260FF)),
              ),
              const SizedBox(height: 10),
              const Text('Are you sure you want to log out?'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(Color(0xFFCAD6FF)),
                      minimumSize: WidgetStatePropertyAll(
                        Size(
                          size.width * 0.34, 
                          size.height * 0.05125
                        )
                      )
                    ),

                    onPressed: _toggleLogoutCard,

                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xFF2260FF), fontFamily: "League Spartan", fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(Color(0xFF2260FF)),
                      minimumSize: WidgetStatePropertyAll(
                        Size(
                          size.width * 0.34, 
                          size.height * 0.05125
                        )
                      )
                    ),
                    onPressed: () => logoutCardEvent(),
                    child: const Text(
                      'Yes, Logout',
                      style: TextStyle(color: Colors.white, fontFamily: "League Spartan", fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }

  void logoutCardEvent() {
    // Handle on tap event here.
    //TO-DO IMPLEMENT
  }
}
