import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_webapp/bloc/DoctorInfo/doctor_info_event.dart';
import 'package:doctor_webapp/bloc/DoctorInfo/doctor_info_state.dart';
import 'package:doctor_webapp/bloc/DoctorInfo/doctor_info_bloc.dart';
import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:doctor_webapp/utils/text_styles.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  final String doctorId;

  const ProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return BlocProvider(
      create: (context) =>
          GetDoctorInfoBloc()..add(GetDoctorInfoEvent(doctorId)),
      child: Scaffold(
        backgroundColor: ColorPalette.blueFormColor,
        body: Row(
          children: [
            // Placeholder space for the side navbar
            Container(
              width: 88,
            ),
            Expanded(
              child: BlocBuilder<GetDoctorInfoBloc, GetDoctorInfoState>(
                builder: (context, state) {
                  if (state is GetDoctorInfoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetDoctorInfoSuccess) {
                    return _buildDoctorProfile(context, state.doctorData, textStyles);
                  } else if (state is GetDoctorInfoError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text("No data available."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorProfile(
      BuildContext context, Map<String, dynamic> doctorData, TextStyles textStyles) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Title
            Text(
              "Profile",
              style: textStyles.getTitleStyle(
                size: 32,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2260FF),
              ),
            ),
            const SizedBox(height: 16),
            // Profile Picture
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: ColorPalette.greyColor,
                  backgroundImage: doctorData['ava_url'] != null
                      ? NetworkImage(doctorData['ava_url'])
                      : const AssetImage('assets/placeholder.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 20,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: ColorPalette.deepBlue,
                    child: const Icon(Icons.edit, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "${doctorData['first_name']} ${doctorData['last_name']}",
              style: textStyles.getTitleStyle(
                size: 22,
                fontWeight: FontWeight.bold,
                color: ColorPalette.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Specialization: ${doctorData['specialization']}",
              style: textStyles.getDescriptionStyle(),
            ),
            Divider(height: 32, color: ColorPalette.greyColor),
            _buildInfoRow(context, textStyles, "First Name", doctorData['first_name']),
            _buildInfoRow(context, textStyles, "Last Name", doctorData['last_name']),
            _buildInfoRow(
              context,
              textStyles,
              "Date of Birth",
              _formatDate(doctorData['date_of_birth']),
            ),
            _buildInfoRow(context, textStyles, "Gender", doctorData['gender']),
            _buildInfoRow(context, textStyles, "Blood Type", doctorData['blood_type']),
            _buildInfoRow(context, textStyles, "Phone Number", doctorData['phone_number']),
            _buildInfoRow(context, textStyles, "Address", doctorData['address']),
            Divider(height: 32, color: ColorPalette.greyColor),
            _buildInfoRow(context, textStyles, "Education", doctorData['education']),
            _buildInfoRow(context, textStyles, "Career", doctorData['career']),
            _buildInfoRow(context, textStyles, "Description", doctorData['description']),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return "N/A";
    final date = DateTime.parse(timestamp);
    return DateFormat('yyyy-MM-dd').format(date); // Format to show only date.
  }

  Widget _buildInfoRow(
      BuildContext context, TextStyles textStyles, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: textStyles.getRegularStyle(
              size: 20,
              fontWeight: FontWeight.w500,
              color: ColorPalette.blackColor,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: textStyles.getRegularStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
