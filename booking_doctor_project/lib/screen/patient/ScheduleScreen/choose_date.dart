import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:flutter/material.dart';

class HorizontalCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final Function(String) onMonthSelected;
  const HorizontalCalendar({
    super.key, 
    required this.onMonthSelected,
    required this.onDateSelected});

  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {

  int selectedIndex = 0; // Default selected date index
  DateTime now = DateTime.now();
  int start = DateTime.now().day; //
  int end = DateTime.now().day+6;

  static const List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  String selectedMonth = months.elementAt(DateTime.now().month-1);

  int daysInMonth(DateTime date) {
    DateTime firstDayNextMonth = (date.month < 12)
        ? DateTime(date.year, date.month + 1, 1)
        : DateTime(date.year + 1, 1, 1);

    DateTime lastDayThisMonth = firstDayNextMonth.subtract(const Duration(days: 1));
    return lastDayThisMonth.day;
  }

  @override
  Widget build(BuildContext context) {
    // Get relative dimensions
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double calendarHeight = screenHeight * 0.4; // 40% of screen height
    final double itemWidth = screenWidth * 0.09; // 13% of screen width
    final double itemHeight = calendarHeight * 0.5; // 50% of calendar height
    late List<DateTime> dates = List.generate(
      daysInMonth(now),
      (index) => now.add(Duration(days: index - now.day + 1)),
    ); // Generate days from today

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: screenWidth,
          height: calendarHeight, // Dynamic height
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: ColorPalette.mediumBlue,
          ),
          child: Column(
            children: [
              // Month selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      selectedMonth,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.deepBlue
                      ),
                    ),
                   DropdownButton<String>(
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blue), // Only show the arrow
                    underline: const SizedBox.shrink(), // Removes the underline
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                        int selectedMonthIndex = 0;
                        for(; months[selectedMonthIndex] == selectedMonth; selectedMonthIndex++) {}
                        now = DateTime(now.year, selectedMonthIndex, now.day);
                      }); 
                      widget.onMonthSelected(selectedMonth);
                    },
                    items: months.map<DropdownMenuItem<String>>((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(
                          month, // Ensure options show correctly in the dropdown
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                  ],
                ),
              ),

              // Calendar list
              Expanded(
                child: Row(
                  children: [
                    // Left arrow
                    IconButton(
                      icon: Icon(Icons.arrow_left, size: screenWidth * 0.05, color: ColorPalette.deepBlue),
                      onPressed: () {
                        setState(() {
                          if (start - 2 >= 0) {
                            start -= 2;
                            end -= 2;
                          }
                          else {
                            start = 0;
                            end = start + 2;
                          }
                        });
                      },
                    ),

                    // Horizontal scrolling dates
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        itemBuilder: (context, index) {
                          print(index);
                          final date = dates[index];
                          final isSelected = index == selectedIndex;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              widget.onDateSelected(dates[index]);
                            },
                            child: Container(
                              width: itemWidth, // Relative width
                              height: itemHeight, // Relative height
                              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                              decoration: BoxDecoration(
                                color: isSelected ? ColorPalette.deepBlue : Colors.white,
                                borderRadius: BorderRadius.circular(itemWidth * 0.4),
                                border: Border.all(
                                  color: isSelected ? ColorPalette.deepBlue : Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${date.day}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"][date.weekday - 1],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected ? Colors.white : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Right arrow
                    IconButton(
                      icon: Icon(Icons.arrow_right, size: screenWidth * 0.05, color: ColorPalette.deepBlue),
                      onPressed: () {
                        setState(() {
                          if (end + 2 <= dates.length) {
                            start += 2;
                            end += 2;
                          }
                          else {
                            start = dates.length - 2;
                            end = dates.length;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: screenHeight * 0.02, // 2% of screen height
                width: screenWidth,
              )
            ],
          ),
        ),
      ),
    );
  }
}

