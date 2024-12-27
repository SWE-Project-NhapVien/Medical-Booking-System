import 'package:admin_webapp/bloc/Logout/logout_bloc.dart';
import 'package:admin_webapp/routes/navigation_services.dart';
import 'package:admin_webapp/screen/report/report_screen.dart';
import 'package:admin_webapp/screen/schedule/schedule_screen.dart';
import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/enum.dart';
import 'package:admin_webapp/utils/fixed_web_component.dart';
import 'package:admin_webapp/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HandlePageView extends StatefulWidget {
  const HandlePageView({super.key});

  @override
  State<HandlePageView> createState() => _HandlePageViewState();
}

class _HandlePageViewState extends State<HandlePageView> {
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

  late bool isFirstTime;

  @override
  void initState() {
    _navigatorType = NavigatorType.home;
    isFirstTime = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      starLoadingScreen();
    });
    super.initState();
  }

  Future starLoadingScreen() async {
    await Future.delayed(const Duration(milliseconds: 400));
    setState(() {
      isFirstTime = false;
      _screen = const ReportScreen();
    });
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
    double lottieSize = MediaQuery.of(context).size.width * 0.6;
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          NavigationServices(context).popUntilLogin();
        } else if (state is LogoutFailure) {
          Dialogs(context).showErrorDialog(message: state.error);
        }
      },
      child: Scaffold(
          backgroundColor: ColorPalette.mediumBlue,
          body: Row(
            children: [
              _buildSideBar(),
              isFirstTime
                  ? Center(
                      child: AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Lottie.network(
                          FixedWebComponent.loading,
                          width: lottieSize,
                        ),
                      ),
                    )
                  : Expanded(
                      child: _screen,
                    ),
            ],
          )),
    );
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
                ? Image.network(
                    FixedWebComponent.logo,
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
              _screen = const ReportScreen();
              _navigatorType = NavigatorType.home;
            }),
          ),
        ),
        Positioned(
          top: _topMainComponentPadding + _mainComponentDistance,
          left: _leftPaddingComponent - 2,
          child: _buildSideBarComponent(
              icon: Icons.calendar_month,
              isSelected: _navigatorType == NavigatorType.schedule,
              onClick: () {
                if (_navigatorType != NavigatorType.schedule) {
                  setState(() {
                    _screen = const ScheduleScreen();
                    _navigatorType = NavigatorType.schedule;
                  });
                }
              }),
        ),
        Positioned(
          left: _leftPaddingComponent,
          bottom: _bottomPadding,
          child: _buildSideBarComponent(
              icon: Icons.logout,
              isSelected: _navigatorType == NavigatorType.logout,
              onClick: () async {
                await Dialogs(context).showLogoutDialog(context, () {
                  BlocProvider.of<LogoutBloc>(context).add(const Logout());
                });
              }),
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
