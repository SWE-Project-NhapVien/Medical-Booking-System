import 'package:booking_doctor_project/bloc/Search/search_bloc.dart';
import 'package:booking_doctor_project/bloc/Search/search_event.dart';
import 'package:booking_doctor_project/bloc/Search/search_state.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResult extends StatefulWidget {
  final String? searchQuery;
  final String? dateQuery;
  const SearchResult(
      {super.key, required this.searchQuery, required this.dateQuery});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late int chosenFilterOption;

  @override
  void initState() {
    // Call BLoC to fetch data here
    chosenFilterOption = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                          if (chosenFilterOption != 0) {
                            setState(() {
                              chosenFilterOption = 0;
                            });
                          }
                        },
                        child: Container(
                          width: 40.0, // Width of the button
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
                              'All',
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
                          if (chosenFilterOption != 1) {
                            setState(() {
                              chosenFilterOption = 1;
                            });
                          }
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
                          if (chosenFilterOption != 2) {
                            setState(() {
                              chosenFilterOption = 2;
                            });
                          }
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
                  BlocProvider(
                      create: (_) => SearchBloc(),
                      child: ResultsView(
                          searchQuery: widget.searchQuery,
                          dateQuery: widget.dateQuery,
                          chosenFilterOption: chosenFilterOption))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResultsView extends StatelessWidget {
  final String? searchQuery;
  final String? dateQuery;
  final int chosenFilterOption;
  const ResultsView(
      {super.key,
      required this.searchQuery,
      required this.dateQuery,
      required this.chosenFilterOption});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchBloc>();
    bloc.add(
        SearchDoctorsEvent(searchQuery: searchQuery, dateQuery: dateQuery));
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchLoading) {
        return const CircularProgressIndicator();
      } else if (state is SearchSuccess) {
        List result = [];
        if (chosenFilterOption == 1) {
          for (var i = 0; i < state.doctors.length; i++) {
            if (state.doctors[i]['gender'] == 'Female') {
              result.add(state.doctors[i]);
            }
          }
        } else if (chosenFilterOption == 2) {
          for (var i = 0; i < state.doctors.length; i++) {
            if (state.doctors[i]['gender'] == 'Male') {
              result.add(state.doctors[i]);
            }
          }
        } else {
          result = state.doctors;
        }
        if (result.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: TextStyle(color: ColorPalette.greyColor),
            ),
          );
        }

        return SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: ColorPalette.mediumBlue, // Blue background
                        borderRadius:
                            BorderRadius.circular(20.0), // Circular shape
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
                                    image: result[index]['ava_url'] == null
                                        ? Image.network(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2F8DoZLvVpkbPZs1z1dBzXKLvgRNwgUrstA&s',
                                          ).image
                                        : Image.network(
                                            result[index]['ava_url'],
                                          ).image)),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                '${result[index]['first_name']} ${result[index]['last_name']}',
                                style: TextStyle(
                                    color: ColorPalette.deepBlue, fontSize: 20),
                              ),
                              const SizedBox(height: 5),
                              Text(result[index]['specialization']
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', '')),
                              const Spacer(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 60.0, // Width of the button
                                      height:
                                          28.0, // Height of the button (same as width for circular shape)
                                      decoration: BoxDecoration(
                                        color: ColorPalette.whiteColor,
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Circular shape
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Info',
                                          style: TextStyle(
                                              color: ColorPalette.deepBlue),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 160, // Width of the button
                                      height:
                                          28.0, // Height of the button (same as width for circular shape)
                                      decoration: BoxDecoration(
                                        color: ColorPalette.deepBlue,
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Circular shape
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Book Appointment',
                                          style: TextStyle(
                                              color: ColorPalette.whiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }));
      }
      return const SizedBox.shrink();
    });
  }
}
