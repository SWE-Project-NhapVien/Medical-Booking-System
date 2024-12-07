import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2F8DoZLvVpkbPZs1z1dBzXKLvgRNwgUrstA&s',
                      ).image)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, Welcome back!",
                      style:
                          TextStyle(color: ColorPalette.deepBlue, fontSize: 14),
                    ),
                    const Text(
                      "John Doe",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 36.0, // Width of the button
                  height:
                      36.0, // Height of the button (same as width for circular shape)
                  decoration: BoxDecoration(
                    color: ColorPalette.mediumBlue, // Blue background
                    shape: BoxShape.circle, // Circular shape
                  ),
                  child: const Icon(
                    Icons.notifications_outlined, // Magnifying glass icon
                    color: Colors.black, // White color for the icon
                    size: 24.0, // Icon size
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/doctors_image.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: TextField(
                      style: TextStyle(color: ColorPalette.deepBlue),
                      showCursor: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 14.0), // Padding inside the text field
                        hintText: 'Search',
                        hintStyle: TextStyle(color: ColorPalette.deepBlue),
                        fillColor: ColorPalette.mediumBlue,
                        filled: true,
                        suffixIconColor: ColorPalette.deepBlue,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(20.0), // Rounded border
                          borderSide: BorderSide.none,
                        ),
                      ),
                      readOnly: true,
                      onTap: () {},
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 36.0, // Width of the button
                  height:
                      36.0, // Height of the button (same as width for circular shape)
                  decoration: BoxDecoration(
                    color: ColorPalette.deepBlue, // Blue background
                    shape: BoxShape.circle, // Circular shape
                  ),
                  child: const Icon(
                    Icons.search, // Magnifying glass icon
                    color: Colors.white, // White color for the icon
                    size: 20.0, // Icon size
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Upcoming ",
                  style: TextStyle(
                    color: ColorPalette.deepBlue,
                  ),
                ),
                Dash(
                  direction: Axis.horizontal, // Horizontal dashed line
                  length: (MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width * 0.1) -
                      70, // Length of the line
                  dashLength: 6, // Length of each dash
                  dashColor: ColorPalette.deepBlue, // Color of the dashes
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
