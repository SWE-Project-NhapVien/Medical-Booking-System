import 'package:booking_doctor_project/screen/appointment/appointment_screen.dart';
import 'package:booking_doctor_project/screen/home/home_screen.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/utils/enum.dart';
import 'package:booking_doctor_project/utils/local_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../screen/profile/profile_screen.dart';

class CommonNavigationBar extends StatefulWidget {
  const CommonNavigationBar({super.key});

  @override
  State<CommonNavigationBar> createState() => _CommonNavigationBarState();
}

class _CommonNavigationBarState extends State<CommonNavigationBar> {
  late Widget _screen;

  late double _sideBarHeight;
  late double _sideBarWidth;

  late double _sideBarComponentHeight;
  late double _sideBarComponentWidth;

  late double _topPadding;
  late double _bottomPadding;

  late double _topMainComponentPadding;
  late double _mainComponentDistance;

  late double _leftPaddingComponent;

  late double thresholdDistanceComponent;

  late NavigatorType _navigatorType;

  @override
  void initState() {
    _navigatorType = NavigatorType.home;
    _screen = const HomeScreen();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    thresholdDistanceComponent = 6;
    _sideBarHeight = MediaQuery.of(context).size.height * 0.95;
    _sideBarWidth = MediaQuery.of(context).size.width * 0.04;

    _sideBarComponentHeight = _sideBarHeight * 0.16;
    _sideBarComponentWidth = _sideBarWidth * 0.72;

    _topPadding = _sideBarHeight * 0.04;
    _bottomPadding = _sideBarHeight * 0.06;

    _topMainComponentPadding = _topPadding * 7;
    _mainComponentDistance = _sideBarHeight * 0.08;

    _leftPaddingComponent = _sideBarWidth * 0.15 + 10;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        _buildSideBar(),
        Expanded(
          child: _screen,
        ),
      ],
    ));
  }
  Widget _buildSideBar() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          height: _sideBarHeight,
          width: _sideBarWidth,
          decoration: BoxDecoration(
            color: ColorPalette.deepBlue,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        Positioned(
            top: _topPadding,
            left: _leftPaddingComponent,
            child: _topPadding > 6
                ? Image.asset(
                    Localfiles.logo,
                    height: _sideBarComponentHeight,
                    width: _sideBarComponentWidth,
                  )
                : Container()),
        Positioned(
          top: _topMainComponentPadding,
          left: _leftPaddingComponent - 2,
          child: _buildSideBarComponent(
            icon: Icons.home,
            isSelected: _navigatorType == NavigatorType.home,
            onClick: () => setState(() {
              _screen = const HomeScreen();
              _navigatorType = NavigatorType.home;
            }),
          ),
        ),
        Positioned(
          top: _topMainComponentPadding + _mainComponentDistance,
          left: _leftPaddingComponent - 2,
          child: _buildSideBarComponent(
            icon: Icons.calendar_month,
            isSelected: _navigatorType == NavigatorType.appointment,
            onClick: () => setState(() {
              _screen = const AppointmentScreen();
              _navigatorType = NavigatorType.appointment;
            }),
          ),
        ),
        Positioned(
          top: _topMainComponentPadding + _mainComponentDistance * 2,
          left: _leftPaddingComponent - 2,
          child: _buildSideBarComponent(
            icon: Icons.person,
            isSelected: _navigatorType == NavigatorType.profile,
            onClick: () => setState(() {
              _screen = const ProfileScreen();
              _navigatorType = NavigatorType.profile;
            }),
          ),
        ),
        Positioned(
          left: _leftPaddingComponent,
          bottom: _bottomPadding,
          child: _buildSideBarComponent(
            icon: Icons.logout,
            isSelected: _navigatorType == NavigatorType.logout,
            onClick: () => {},
          ),
        ),
      ],
    );
  }

  Widget _buildSideBarComponent(
      {required IconData icon,
      required bool isSelected,
      required VoidCallback onClick}) {
    Color selectedColor = ColorPalette.backgroundSelectSideBarComponent;

    if (_bottomPadding <= 9 && icon == Icons.logout) {
      return Container();
    } else if (_mainComponentDistance < thresholdDistanceComponent &&
        icon != Icons.logout) {
      if (!isSelected) {
        return Container();
      }
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onClick(),
        child: Container(
          height: _sideBarComponentHeight * 0.4,
          width: _sideBarWidth * 0.722,
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: FittedBox(child: Icon(icon, color: ColorPalette.whiteColor)),
        ),
      ),
    );
  }
}
