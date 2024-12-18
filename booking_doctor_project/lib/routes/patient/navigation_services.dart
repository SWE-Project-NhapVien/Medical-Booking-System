import 'package:booking_doctor_project/class/appointment.dart';
import 'package:booking_doctor_project/screen/AppointmentScreen/appointment_detail.dart';
import 'package:booking_doctor_project/screen/AppointmentScreen/appointment_screen.dart';
import 'package:booking_doctor_project/screen/DoctorInfo/doctor_info_screen.dart';
import 'package:booking_doctor_project/screen/Notification/notification_screen.dart';
import 'package:booking_doctor_project/screen/SearchScreen/search_result.dart';
import 'package:booking_doctor_project/screen/SearchScreen/search_screen.dart';
import 'package:booking_doctor_project/screen/patient/CreateProfileScreen/create_profile_screen.dart';
import 'package:booking_doctor_project/screen/patient/LoginScreen/choose_profile_screen.dart';
import 'package:booking_doctor_project/screen/patient/ScheduleScreen/schedule_screen.dart';
import 'package:booking_doctor_project/widgets/home_page.dart';
import 'package:flutter/material.dart';

import '../../screen/patient/LoginAndSignUp/login_and_signup_screen.dart';

class NavigationServices {
  final BuildContext context;
  NavigationServices(this.context);

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget, fullscreenDialog: fullscreenDialog));
  }

  Future<dynamic> pushLogInScreen() async {
    return _pushMaterialPageRoute(LoginOrSignUpScreen(showLoginScreen: true));
  }

  Future<dynamic> pushSignUpScreen() async {
    return _pushMaterialPageRoute(LoginOrSignUpScreen(showLoginScreen: false));
  }

  Future<dynamic> pushCompleteProfileScreen() async {
    return _pushMaterialPageRoute(const CreateProfileScreen());
  }

  Future<dynamic> pushAppointmentDetail(
      {required Appointment appointment}) async {
    return _pushMaterialPageRoute(AppointmentDetail(
      appointment: appointment,
    ));
  }

  Future<dynamic> pushChooseProfileScreen() async {
    return _pushMaterialPageRoute(const ChooseProfileScreen());
  }

  Future<dynamic> pushAppointmentScreen() async {
    return _pushMaterialPageRoute(const AppointmentScreen());
  }

  Future<dynamic> pushNotificationScreen(List<String> notiList) async {
    return _pushMaterialPageRoute(NotificationScreen(notiId: notiList));
  }

  Future<dynamic> pushSearchScreen() async {
    return _pushMaterialPageRoute(const SearchScreen());
  }

  Future<dynamic> pushSearchResultScreen(
      String? dateQuery, String? searchQuery) async {
    return _pushMaterialPageRoute(SearchResult(
      dateQuery: dateQuery,
      searchQuery: searchQuery,
    ));
  }

  Future<dynamic> pushDoctorInfoScreen(String doctorId) async {
    return _pushMaterialPageRoute(DoctorInfoScreen(
      doctorId: doctorId,
    ));
  }

  Future<dynamic> pushHomeScreen() async {
    return _pushMaterialPageRoute(const HomePage());
  }

  Future<dynamic> pushScheduleScreen(String doctorId) async {
    return _pushMaterialPageRoute(ScheduleScreen(doctorId: doctorId));
  }
}
