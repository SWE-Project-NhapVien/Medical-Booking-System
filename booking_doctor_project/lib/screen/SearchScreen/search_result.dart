import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  int chosenFilterOption = 0;
  List<String> data = ['Dr. Alexander Bennett, Ph.D.', 'Dr. John Doe, M.D.'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonAppBarView(
            iconData: Icons.arrow_back_ios,
            title: "Doctors",
            onBackClick: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Sort by: '),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          chosenFilterOption = 0;
                        });
                      },
                      child: Container(
                        width: 60.0, // Width of the button
                        height:
                            28.0, // Height of the button (same as width for circular shape)
                        decoration: BoxDecoration(
                          color: chosenFilterOption == 0
                              ? ColorPalette.deepBlue
                              : ColorPalette.mediumBlue, // Blue background
                          borderRadius:
                              BorderRadius.circular(20.0), // Circular shape
                        ),
                        child: Center(
                          child: Text(
                            'A → Z',
                            style: TextStyle(
                                color: chosenFilterOption == 0
                                    ? ColorPalette.whiteColor
                                    : ColorPalette.deepBlue),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          chosenFilterOption = 1;
                        });
                      },
                      child: Container(
                        width: 28.0, // Width of the button
                        height:
                            28.0, // Height of the button (same as width for circular shape)
                        decoration: BoxDecoration(
                          color: chosenFilterOption == 1
                              ? ColorPalette.deepBlue
                              : ColorPalette.mediumBlue, // Blue background
                          shape: BoxShape.circle, // Circular shape
                        ),
                        child: Icon(
                          Icons.female, // Magnifying glass icon
                          color: chosenFilterOption == 1
                              ? ColorPalette.whiteColor
                              : ColorPalette
                                  .deepBlue, // White color for the icon
                          size: 20.0, // Icon size
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          chosenFilterOption = 2;
                        });
                      },
                      child: Container(
                        width: 28.0, // Width of the button
                        height:
                            28.0, // Height of the button (same as width for circular shape)
                        decoration: BoxDecoration(
                          color: chosenFilterOption == 2
                              ? ColorPalette.deepBlue
                              : ColorPalette.mediumBlue, // Blue background
                          shape: BoxShape.circle, // Circular shape
                        ),
                        child: Icon(
                          Icons.male, // Magnifying glass icon
                          color: chosenFilterOption == 2
                              ? ColorPalette.whiteColor
                              : ColorPalette
                                  .deepBlue, // White color for the icon
                          size: 20.0, // Icon size
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color:
                                    ColorPalette.mediumBlue, // Blue background
                                borderRadius: BorderRadius.circular(
                                    20.0), // Circular shape
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: Image.network(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2F8DoZLvVpkbPZs1z1dBzXKLvgRNwgUrstA&s',
                                        ).image)),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        data[index],
                                        style: TextStyle(
                                            color: ColorPalette.deepBlue,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text('Dermato Genetics'),
                                      const Spacer(),
                                      Container(
                                        width: 60.0, // Width of the button
                                        height:
                                            28.0, // Height of the button (same as width for circular shape)
                                        decoration: BoxDecoration(
                                          color: ColorPalette.deepBlue,
                                          borderRadius: BorderRadius.circular(
                                              20.0), // Circular shape
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Info',
                                            style: TextStyle(
                                                color: ColorPalette.whiteColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
              ],
            ),
          )
        ],
      ),
    );
  }
}
