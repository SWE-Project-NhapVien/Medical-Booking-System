import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/Examine/examine_bloc.dart';
import '../../bloc/Examine/examine_event.dart';
import '../../bloc/Examine/examine_state.dart';

class ExamineScreen extends StatelessWidget {
  final String appointmentId;

  const ExamineScreen({Key? key, required this.appointmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExamineBloc()..add(FetchAppointmentDetails(appointmentId)),
      child: Scaffold(
        backgroundColor: const Color(0xFFECF1FF),
        body: BlocBuilder<ExamineBloc, ExamineState>(
          builder: (context, state) {
            if (state is ExamineLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExamineLoaded) {
              final patientInfo = state.appointmentDetails['patientInfo'];
              final doctorNotes = state.appointmentDetails['doctorNotes'];

              return Row(
                children: [
                  // Sidebar
                  Container(
                    width: 88,
                    height: double.infinity,
                    color: const Color(0xFF2260FF),
                  ),
                  // Main Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                // Patient Information
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Patient Information",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text("Name: ${patientInfo['name']}"),
                                        Text("Gender: ${patientInfo['gender']}"),
                                        Text("Date of Birth: ${patientInfo['dob']}"),
                                        Text("Blood Type: ${patientInfo['bloodType']}"),
                                        const SizedBox(height: 16),
                                        Text("Allergies: ${patientInfo['allergies']}"),
                                        Text("Medical History: ${patientInfo['medicalHistory']}"),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Doctor's Notes
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Doctor's Notes",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text("Symptoms: ${doctorNotes['symptoms']}"),
                                        Text("Diagnoses: ${doctorNotes['diagnoses']}"),
                                        Text("Medicines: ${doctorNotes['medicines']}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ExamineError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
