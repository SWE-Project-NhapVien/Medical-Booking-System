import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
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
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.07
              ),
              child: const Text(
                "Privacy Policy",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF2260FF), fontWeight: FontWeight.bold, fontSize: 24),
              )
            )
          ),

          // Last updated
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.13125,
            ),
            child: SizedBox (
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.08333,
                      ),
                      child: const Text(
                        "Last updated: 2023-08-14",
                        style: TextStyle(color: Color(0xFFA9BCFE), fontSize: 16),
                      )
                    )
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.08333,
                        right: MediaQuery.of(context).size.width * 0.08333
                      ),
                      child: const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing "
                        "elit. Praesent pellentesque congue lorem, vel "
                        "tincidunt tortor placerat a. Proin ac diam quam. "
                        "Aenean in sagittis magna, ut feugiat diam. Fusce a scelerisque neque, sed accumsan metus.\n\n"
                        "Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. Aenean arcu metus, bibendum at rhoncus at, "
                        "volutpat ut lacus. Morbi pellentesque malesuada eros semper ultrices. Vestibulum lobortis enim vel neque "
                        "auctor, a ultrices ex placerat. Mauris ut lacinia justo, sed suscipit tortor. Nam egestas nulla posuere "
                        "neque tincidunt porta.",
                        style: TextStyle(color: Color(0xFF000000), fontSize: 14),
                        textAlign: TextAlign.justify,
                      )
                    )
                  ),

                  // Terms & Conditions
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03125,
                        left: MediaQuery.of(context).size.width * 0.08333,
                        right: MediaQuery.of(context).size.width * 0.08333
                      ),
                      child: const Text(
                        "Terms & Conditions",
                        style: TextStyle(color: Color(0xFF2260FF), fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    )
                  ),

                  // Temrs
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.08333,
                        right: MediaQuery.of(context).size.width * 0.08333
                      ),
                      child: const Text(
                        "1. Ut lacinia justo sit amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros est vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisl posuere risus, vel facilisis nisi tellus ac turpis. \n\n"
                        "2. Ut lacinia justo sit amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros est vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisl posuere risus, vel facilisis nisi tellus. \n\n"
                        "3. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.\n\n"
                        "4. Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. Aenean arcu metus, bibendum at rhoncus at, volutpat ut lacus. Morbi pellentesque malesuada eros semper ultrices. Vestibulum lobortis enim vel neque auctor, a ultrices ex placerat. Mauris ut lacinia justo, sed suscipit tortor. Nam egestas nulla posuere neque.",
                        style: TextStyle(color: Color(0xFF000000), fontSize: 14),
                        textAlign: TextAlign.justify,
                      )
                    )
                  ),

                ]),
              )
            )
          ),
          
          
        ],
      )
    );
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
    Navigator.pop(context);
  }
}