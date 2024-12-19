import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_webapp/bloc/DoctorInfo/doctor_info_event.dart';
import 'package:doctor_webapp/bloc/DoctorInfo/doctor_info_state.dart';
import 'package:doctor_webapp/bloc/DoctorInfo/doctor_info_bloc.dart';
import 'package:doctor_webapp/utils/color_palette.dart';

class ProfileScreen extends StatelessWidget {
  final String doctorId;

  const ProfileScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
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
              color: ColorPalette.deepBlue,
            ),
            Expanded(
              child: BlocBuilder<GetDoctorInfoBloc, GetDoctorInfoState>(
                builder: (context, state) {
                  if (state is GetDoctorInfoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetDoctorInfoSuccess) {
                    return _buildDoctorProfile(state.doctorData);
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

  Widget _buildDoctorProfile(Map<String, dynamic> doctorData) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorPalette.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Specialization: ${doctorData['specialization']}",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: ColorPalette.greyColor,
              ),
            ),
            Divider(height: 32, color: ColorPalette.greyColor),
            _buildInfoRow("Date of Birth", doctorData['date_of_birth']),
            _buildInfoRow("Gender", doctorData['gender']),
            _buildInfoRow("Blood Type", doctorData['blood_type']),
            _buildInfoRow("Phone Number", doctorData['phone_number']),
            _buildInfoRow("Address", doctorData['address']),
            Divider(height: 32, color: ColorPalette.greyColor),
            _buildInfoRow("Education", doctorData['education']),
            _buildInfoRow("Career", doctorData['career']),
            _buildInfoRow("Description", doctorData['description']),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorPalette.blackColor,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: TextStyle(
                color: ColorPalette.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
