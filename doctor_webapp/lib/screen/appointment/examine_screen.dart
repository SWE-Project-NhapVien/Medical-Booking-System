import 'dart:convert';

import 'package:doctor_webapp/bloc/Examine/doctor_notes_bloc.dart';
import 'package:doctor_webapp/bloc/Examine/doctor_notes_event.dart';
import 'package:doctor_webapp/bloc/Examine/doctor_notes_state.dart';
import 'package:doctor_webapp/bloc/Examine/patientinfo_bloc.dart';
import 'package:doctor_webapp/bloc/Examine/patientinfo_event.dart';
import 'package:doctor_webapp/bloc/Examine/patientinfo_state.dart';
import 'package:doctor_webapp/widgets/textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExamineScreen extends StatelessWidget {
  final String appointmentId;

  const ExamineScreen({Key? key, required this.appointmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation bar placeholder
          SizedBox(width: 88),

          // Main content area
          Expanded(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => PatientInfoBloc()
                    ..add(FetchPatientInfoEvent(appointmentId)),
                ),
                BlocProvider(
                  create: (context) => DoctorNotesBloc(),
                ),
              ],
              child: Column(
                children: [
                  // Patient Information Panel
                  PatientInformationPanel(),

                  // Spacer
                  const SizedBox(height: 16),

                  // Doctor's Notes
                  DoctorNotes(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientInformationPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientInfoBloc, PatientInfoState>(
      builder: (context, state) {
        if (state is PatientInfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PatientInfoLoaded) {
          final patientData = state.appointmentDetails;
          return Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Patient Name: ${patientData['name']}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Age: ${patientData['age']}'),
                  Text('Condition: ${patientData['condition']}'),
                ],
              ),
            ),
          );
        } else if (state is PatientInfoError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class DoctorNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController symptomsController = TextEditingController();
    final TextEditingController diagnosisController = TextEditingController();
    final TextEditingController prescriptionsController = TextEditingController();

    return BlocConsumer<DoctorNotesBloc, DoctorNotesState>(
      listener: (context, state) {
        if (state is DoctorNotesAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Doctor notes added successfully.')),
          );
        } else if (state is DoctorNotesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is DoctorNotesAdding) {
          return const Center(child: CircularProgressIndicator());
        }

        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Doctor\'s Notes:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                // Symptoms Field
                LabelAndTextField(
                  context: context,
                  label: "Symptoms",
                  hintText: "Enter symptoms here...",
                  controller: symptomsController,
                  errorText: "Symptoms cannot be empty",
                ),
                const SizedBox(height: 16),

                // Diagnosis Field
                LabelAndTextField(
                  context: context,
                  label: "Diagnosis",
                  hintText: "Enter diagnosis here...",
                  controller: diagnosisController,
                  errorText: "Diagnosis cannot be empty",
                ),
                const SizedBox(height: 16),

                // Prescriptions Field
                LabelAndTextField(
                  context: context,
                  label: "Prescriptions (JSON format)",
                  hintText: "Enter prescriptions in JSON format...",
                  controller: prescriptionsController,
                  errorText: "Prescriptions cannot be empty",
                  height: 150,
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    final symptoms = symptomsController.text.trim();
                    final diagnosis = diagnosisController.text.trim();
                    final prescriptionsText = prescriptionsController.text.trim();

                    if (symptoms.isEmpty || diagnosis.isEmpty || prescriptionsText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("All fields must be filled")),
                      );
                      return;
                    }

                    Map<String, dynamic> prescriptions;
                    try {
                      prescriptions = Map<String, dynamic>.from(
                        prescriptionsText.isNotEmpty
                            ? jsonDecode(prescriptionsText)
                            : {},
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Invalid JSON format for prescriptions")),
                      );
                      return;
                    }

                    context.read<DoctorNotesBloc>().add(
                          AddDoctorNoteEvent(
                            appointmentId: "someAppointmentId", // Replace with dynamic value
                            symptoms: symptoms,
                            diagnosis: diagnosis,
                            prescriptions: prescriptions,
                          ),
                        );
                  },
                  child: const Text('Save Notes'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


