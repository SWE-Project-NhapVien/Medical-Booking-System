import 'package:booking_doctor_project/bloc/patient/CancelAppointment/cancel_appointment_bloc.dart';
import 'package:booking_doctor_project/class/appointment.dart';
import 'package:booking_doctor_project/class/patient_profile.dart';
import 'package:booking_doctor_project/utils/text_styles.dart';
import 'package:booking_doctor_project/utils/color_palette.dart';
import 'package:booking_doctor_project/widgets/common_app_bar_view.dart';
import 'package:booking_doctor_project/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/comon_button.dart';

class AppointmentDetail extends StatefulWidget {
  const AppointmentDetail({super.key, required this.appointment});

  final Appointment appointment;

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  late Future<PatientProfile?> patientProfile;
  @override
  void initState() {
    patientProfile = PatientProfile.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<CancelAppointmentBloc, CancelAppointmentState>(
      listener: (context, state) async {
        if (state is CancelAppointmentSuccess) {
          await Dialogs(context).showErrorDialog(
            title: 'Cancel an Appointment',
            message: 'You have cancelled this appointment.',
          );
          Navigator.pop(context);
        } else if (state is CancelAppointmentError) {
          Navigator.pop(context);
          await Dialogs(context).showErrorDialog(message: state.error);
        } else if (state is CancelAppointmentProcess) {
          // Navigator.pop(context);
          await Dialogs(context).showLoadingDialog();
        }
      },
      child: Scaffold(
        backgroundColor: ColorPalette.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Custom AppBar
              CommonAppBarView(
                iconData: Icons.arrow_back_ios_new_rounded,
                title: 'Appointment Detail',
                onBackClick: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(context, 'Time'),
                    _sectionContent(context,
                        '${widget.appointment.appointmentTime} - ${widget.appointment.appointmentDate}'),
                    _divider(size),
                    _sectionTitle(context, 'Patient Details'),
                    FutureBuilder<PatientProfile?>(
                      future: patientProfile,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError || snapshot.data == null) {
                          return const Center(
                              child: Text('No patient details found.'));
                        }
                        final profile = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _informationBox(context,
                                title: 'Name',
                                info:
                                    '${profile.firstName} ${profile.lastName}'),
                            _informationBox(context,
                                title: 'Age',
                                info: _calculateAge(profile.dob).toString()),
                            _informationBox(context,
                                title: 'Gender', info: profile.gender),
                            _divider(size),
                            _sectionTitle(context, 'Patient Details'),
                            _appointmentNote(
                              size,
                              note: profile.medicalHistory!.isNotEmpty
                                  ? profile.medicalHistory!.join('\n')
                                  : 'No medical history found.',
                            ),
                            if (widget.appointment.status == 'completed')
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _divider(size),
                                  _sectionTitle(context, 'Doctor\'s Note'),
                                  _appointmentNote(
                                    size,
                                    note: 'Doctor have not noted.',
                                  )
                                ],
                              )
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 22),
                    if (widget.appointment.status == 'upcoming')
                      CommonButton(
                        buttonText: 'Cancel',
                        fontSize: 18,
                        backgroundColor: ColorPalette.redColor,
                        onTap: () {
                          context.read<CancelAppointmentBloc>().add(
                              CancelAppointmentRequired(
                                  appointmentId:
                                      widget.appointment.appointmentId));
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateAge(String dob) {
    final birthDate = DateTime.parse(dob);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // Widget for section titles
  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyles(context).getRegularStyle(color: ColorPalette.deepBlue),
    );
  }

  // Widget for section content
  Widget _sectionContent(BuildContext context, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        content,
        style: TextStyles(context).getRegularStyle(),
      ),
    );
  }

  // Divider widget
  Widget _divider(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
          width: double.infinity, child: Divider(color: ColorPalette.deepBlue)),
    );
  }

  // Widget for displaying information (e.g., name, age, etc.)
  Widget _informationBox(BuildContext context,
      {required String title, required String info}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles(context).getRegularStyle(size: 12),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.0),
            color: ColorPalette.lightBlue,
          ),
          child: Text(
            info,
            style: TextStyles(context).getRegularStyle(
                size: 12, color: ColorPalette.lightBlueTextColor),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }

  // Widget for appointment notes
  Widget _appointmentNote(Size size, {required String note}) {
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: ColorPalette.mediumBlue),
      ),
      child: Text(
        note,
        style: TextStyles(context).getRegularStyle(size: 12),
      ),
    );
  }
}
