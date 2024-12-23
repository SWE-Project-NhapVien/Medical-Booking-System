import 'package:booking_doctor_project/bloc/History/history_bloc.dart';
import 'package:booking_doctor_project/bloc/History/history_event.dart';
import 'package:booking_doctor_project/bloc/History/history_state.dart';
import 'package:booking_doctor_project/class/global_profile.dart';
import 'package:booking_doctor_project/routes/patient/navigation_services.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/localfiles.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController dateController;
  late TextEditingController searchController;

  @override
  void initState() {
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
      backgroundColor: ColorPalette.whiteColor,
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
              child: BlocProvider(
                create: (_) => GetHistoryBloc(),
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
                              hintStyle:
                                  TextStyle(color: ColorPalette.deepBlue),
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
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded border
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
                                    left:
                                        14.0), // Padding inside the text field
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
                        BlocConsumer<GetHistoryBloc, GetHistoryState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                if (searchController.text != '') {
                                  context.read<GetHistoryBloc>().add(
                                      UpdateHistoryDataEvent(
                                          patientId: GlobalProfile().profileId!,
                                          newHistory: searchController.text));
                                }
                                NavigationServices(context)
                                    .pushSearchResultScreen(
                                        dateController.text == ''
                                            ? null
                                            : dateController.text,
                                        searchController.text);
                                searchController.text = '';
                              },
                              child: Container(
                                width: 36.0, // Width of the button
                                height:
                                    36.0, // Height of the button (same as width for circular shape)
                                decoration: BoxDecoration(
                                  color:
                                      ColorPalette.deepBlue, // Blue background
                                  shape: BoxShape.circle, // Circular shape
                                ),
                                child: const Icon(
                                  Icons.search, // Magnifying glass icon
                                  color:
                                      Colors.white, // White color for the icon
                                  size: 20.0, // Icon size
                                ),
                              ),
                            );
                          },
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
                    const HistoryView(),
                  ],
                ),
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
        dateController.text = '${picked.year}-${picked.month}-${picked.day}';
      });
    }
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GetHistoryBloc>();
    bloc.add(GetHistoryDataEvent(paptientId: GlobalProfile().profileId!));
    return BlocBuilder<GetHistoryBloc, GetHistoryState>(
      builder: (context, state) {
        if (state is GetHistoryLoading) {
          return Center(
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: Lottie.asset(
                Localfiles.loading,
                width: 100,
              ),
            ),
          );
        } else if (state is GetHistorySuccess) {
          if (state.history[0]['history'] == null) {
            return Center(
                child: Text(
              'No history found',
              style: TextStyle(
                color: ColorPalette.greyColor,
              ),
            ));
          }
          return SizedBox(
              height: MediaQuery.of(context).size.height - 300,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.history[0]['history'].length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        BlocConsumer<GetHistoryBloc, GetHistoryState>(
                          listener: (context, state2) {},
                          builder: (context, state2) {
                            return TextButton(
                              onPressed: () {
                                context.read<GetHistoryBloc>().add(
                                    UpdateHistoryDataEvent(
                                        patientId: GlobalProfile().profileId!,
                                        newHistory: state.history[0]['history']
                                            [index]));
                                NavigationServices(context)
                                    .pushSearchResultScreen(null,
                                        state.history[0]['history'][index]);
                              },
                              style: TextButton.styleFrom(
                                overlayColor: Colors.transparent,
                              ),
                              child: Text(
                                state.history[0]['history'][index],
                                style: TextStyle(
                                    color: ColorPalette.deepBlue, fontSize: 18),
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        BlocConsumer<GetHistoryBloc, GetHistoryState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () {
                                context.read<GetHistoryBloc>().add(
                                    DeleteHistoryDataEvent(
                                        patientId: GlobalProfile().profileId!,
                                        index: index + 1));
                              },
                              icon: Icon(Icons.highlight_remove,
                                  color: ColorPalette.deepBlue),
                            );
                          },
                        ),
                      ],
                    );
                  }));
        } else if (state is GetHistoryError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
