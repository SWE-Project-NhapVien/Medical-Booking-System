import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  Map<String, dynamic>? patientData; // Store fetched patient data
  bool _showLogoutCard = false;

  @override
  void initState() {
    super.initState();
    _fetchPatientProfile();
  }

  Future<void> _fetchPatientProfile() async {
    final response = await Supabase.instance.client
        .from('patientprofiles')
        .select()
        .eq('user_id', globalPatientId)
        .single(); // Fetch single row

    if (response != null) {
      setState(() {
        patientData = response;
      });
    } else {
      debugPrint('No data found for patient ID: $globalPatientId');
    }
  }

  void _toggleLogoutCard() {
    setState(() {
      _showLogoutCard = !_showLogoutCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Display loading until patient data is fetched
    if (patientData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          _backButton(context),

          // My Profile
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.07),
              child: const Text(
                "My Profile",
                style: TextStyle(
                  color: Color(0xFF2260FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),

          // ImageProfile and EditIcon
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.133),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: patientData!['ava_url'] != null
                        ? NetworkImage(patientData!['ava_url'])
                        : const AssetImage('assets/images/default_profile.png')
                            as ImageProvider,
                  ),
                  Positioned(
                    bottom: -size.height * 0.009,
                    right: -size.width * 0.005,
                    child: _editButton(),
                  )
                ],
              ),
            ),
          ),

          // Name
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.28),
              child: Text(
                '${patientData!['first_name']} ${patientData!['last_name']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),

          // Profile Info, Policy, Switch Profile, Logout
          _buildMenuOptions(size),
          if (_showLogoutCard) _buildLogoutOverlay(size),
        ],
      ),
    );
  }

  Widget _buildMenuOptions(Size size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.083,
        size.height * 0.37,
        0,
        0,
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
    return IconButton(
      icon: const Icon(Icons.edit, color: Color(0xFF2260FF)),
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

  // Policy Layout
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

  // Logout Layout
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

  Widget _buildLogoutOverlay(Size size) {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: Center(
          child: _logoutCard(size),
        ),
      ),
    );
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
