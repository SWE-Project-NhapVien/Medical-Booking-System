import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget{
  const EditProfile({super.key});
  
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backButton(context),

          // My Profile
          Align(
            alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                child: const Text(
                  "Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF2260FF), fontWeight: FontWeight.bold, fontSize: 24),
                ),
              )
            ),

          // ImageProfile and EditIcon
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13321,),
              child: 
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/test_profile_image.png',
                      fit:BoxFit.none
                    ),
                  ],
                )
            )
          ),

          // First Name, Last Name, ..., Emergency contact
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.075, 
              MediaQuery.of(context).size.height * 0.295, 
              0, 
              0,
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.height * 1,
                height: MediaQuery.of(context).size.height * 0.552,
                child: SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //First name, Last name
                  _firstNameAndLastNameText(context),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _firstNameAndLastNameTextField(context),

                  //Phone number
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _phoneNumberText(),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _phoneNumberTextField(context),

                  // National ID
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _nationalIDText(),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _nationalIDTextField(context),

                  // Address
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _addressText(),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _addressTextField(context),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  //Gender and Date of Birth
                  _genderAndDOBText(context),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _genderAndDOBTextField(context),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _bloodText(),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  _bloodTextField(context),
                ],
                ),
              )
            ),
          ),
          
          // Edit Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
              child: _editButton(context),
            ),
          ),
        ],
      ),
    );
  
  }

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
              onPressed: () => backButtonAndEditButtonEvent(context),
            )
          );
  }

  void backButtonAndEditButtonEvent(BuildContext context) {
    // Handle back button click event here.
    Navigator.pop(context);
  }

  //Edit button
  Widget _editButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Color(0xFF2260FF)),
        minimumSize: WidgetStatePropertyAll(Size(MediaQuery.of(context).size.width * 0.575, 41))
      ),
      onPressed: () => backButtonAndEditButtonEvent(context),
      child: const Text(
        'Edit',
        style: TextStyle(color: Colors.white, fontFamily: "League Spartan", fontSize: 20, fontWeight: FontWeight.bold)
      ),
    );
  }

  //First Name and Last Name
  Widget _firstNameAndLastNameText(BuildContext context) {
    return Row(
      children: [
        //First Name
        const Text(
          'First Name',
          style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 20)
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.05278,
        ),

        const Text(
          'Last Name',
          style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 20)
        ),
      ],
    );
  }

  Widget _firstNameAndLastNameTextField(BuildContext context) {
    return Row(
      children: [
        //First Name
        Container(
          width: MediaQuery.of(context).size.width * 0.29,
          height: MediaQuery.of(context).size.height * 0.05625,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFECF1FF)
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
                keyboardType: TextInputType.name,
                style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 15)
              )
            )
          )
        ),

        const Spacer(),

        //Last name
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.51667,
            height: MediaQuery.of(context).size.height * 0.05625,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFECF1FF)
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 15)
                )
              )
            )
          )
        ),

      ],
    );
  }

  //Phone number
  Widget _phoneNumberText() {
    return const Row(
      children: [
        //Phone number
        Text(
          'Phone Number',
          style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 20)
        )
      ]
    );
  }

  Widget _phoneNumberTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.83333,
      height: MediaQuery.of(context).size.height * 0.05625,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFECF1FF)
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none
            ),
            keyboardType: TextInputType.phone,
            style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 15)
          )
        )
      )
    );
  }

  //National ID
  Widget _nationalIDText() {
    return const Row(
      children: [
        //Phone number
        Text(
          'National ID',
          style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 20)
        )
      ]
    );
  }

  Widget _nationalIDTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.83333,
      height: MediaQuery.of(context).size.height * 0.05625,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFECF1FF)
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none
            ),
            keyboardType: TextInputType.phone,
            style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 15)
          )
        )
      )
    );
  }

  //Address
  Widget _addressText() {
    return const Row(
      children: [
        //Phone number
        Text(
          'Address',
          style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 20)
        )
      ]
    );
  }

  Widget _addressTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.83333,
      height: MediaQuery.of(context).size.height * 0.05625,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFECF1FF)
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none
            ),
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 15)
          )
        )
      )
    );
  }

  //First Name and Last Name
  Widget _genderAndDOBText(BuildContext context) {
    return Row(
      children: [
        //First Name
        const Text(
          'Gender',
          style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 20)
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.13333,
        ),

        const Text(
          'Date of Birth',
          style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 20)
        ),
      ],
    );
  }

  Widget _genderAndDOBTextField(BuildContext context) {
    return Row(
      children: [
        //First Name
        Container(
          width: MediaQuery.of(context).size.width * 0.29,
          height: MediaQuery.of(context).size.height * 0.05625,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFECF1FF)
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
                keyboardType: TextInputType.name,
                style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 15)
              )
            )
          )
        ),

        const Spacer(),

        //Last name
        Padding(
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.51667,
            height: MediaQuery.of(context).size.height * 0.05625,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFECF1FF)
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 15)
                )
              )
            )
          )
        ),

      ],
    );
  }

  //Blood
  Widget _bloodText() {
    return const Row(
      children: [
        //Phone number
        Text(
          'Blood Type',
          style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 20)
        )
      ]
    );
  }

  Widget _bloodTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.83333,
      height: MediaQuery.of(context).size.height * 0.05625,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFECF1FF)
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none
            ),
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(fontFamily: "Leauge Spartan", fontWeight: FontWeight.bold, fontSize: 15)
          )
        )
      )
    );
  }
}