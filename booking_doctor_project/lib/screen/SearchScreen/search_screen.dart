import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController dateController;
  late TextEditingController searchController;
  List<String> data = ['Dr. Alexander Bennett, Ph.D.', 'Dr. John Doe, M.D.'];

  @override
  void initState() {
    // Call BLoC to fetch data here
    dateController = TextEditingController();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonAppBarView(
              iconData: Icons.arrow_back_ios,
              title: "Search",
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
                      SizedBox(
                        width: 140,
                        height: 36,
                        child: TextField(
                          controller: dateController,
                          style: TextStyle(color: ColorPalette.deepBlue),
                          showCursor: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 14.0), // Padding inside the text field
                            hintText: 'Date',
                            hintStyle: TextStyle(color: ColorPalette.deepBlue),
                            fillColor: ColorPalette.mediumBlue,
                            filled: true,
                            suffixIcon: dateController.text == ''
                                ? const Icon(Icons.arrow_drop_down)
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        dateController.clear();
                                      });
                                    },
                                    child: Icon(Icons.clear,
                                        color: ColorPalette.deepBlue),
                                  ),

                            suffixIconColor: ColorPalette.deepBlue,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(20.0), // Rounded border
                              borderSide: BorderSide.none,
                            ),
                          ),
                          readOnly: true,
                          onTap: () => selectDate(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 36,
                          child: TextField(
                            controller: searchController,
                            style: TextStyle(color: ColorPalette.deepBlue),
                            cursorColor: ColorPalette.deepBlue,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0), // Padding inside the text field
                              hintText: 'Doctor name or specialization',
                              hintStyle:
                                  TextStyle(color: ColorPalette.deepBlue),
                              fillColor: ColorPalette.mediumBlue,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded border
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded border
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded border
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          NavigationServices(context).pushSearchResultScreen(
                              dateController.text == ''
                                  ? null
                                  : dateController.text,
                              searchController.text);
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'History',
                        style: TextStyle(color: ColorPalette.greyColor),
                      ),
                      const SizedBox(width: 4),
                      Dash(
                        direction: Axis.horizontal, // Horizontal dashed line
                        length: (MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 0.1) -
                            51, // Length of the line
                        dashLength: 6, // Length of each dash
                        dashColor:
                            ColorPalette.greyColor, // Color of the dashes
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
                            return Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      //overlayColor: Colors.transparent,
                                      ),
                                  child: Text(
                                    data[index],
                                    style: TextStyle(
                                        color: ColorPalette.deepBlue,
                                        fontSize: 18),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.highlight_remove,
                                      color: ColorPalette.deepBlue),
                                )
                              ],
                            );
                          })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime(2025));

    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
