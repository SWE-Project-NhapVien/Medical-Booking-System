import 'package:doctor_webapp/bloc/Examine/doctor_notes_bloc.dart';
import 'package:doctor_webapp/bloc/Examine/doctor_notes_event.dart';
import 'package:doctor_webapp/bloc/Examine/doctor_notes_state.dart';
import 'package:doctor_webapp/bloc/Examine/patientinfo_bloc.dart';
import 'package:doctor_webapp/bloc/Examine/patientinfo_event.dart';
import 'package:doctor_webapp/bloc/Examine/patientinfo_state.dart';
import 'package:doctor_webapp/utils/color_palette.dart';
import 'package:doctor_webapp/widgets/comon_button.dart';
import 'package:doctor_webapp/widgets/textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExamineScreen extends StatelessWidget {
  final String appointmentId;

  const ExamineScreen({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.blueFormColor,
      body: Row(
        children: [
          // Navigation bar placeholder
          const SizedBox(width: 88),

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
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Examine Patient',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.deepBlue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Patient Information Panel
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: PatientInformationPanel(),
                            ),
                          ),

                          // Divider
                          Container(
                            width: 10,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 32),
                          ),

                          // Doctor's Notes
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: DoctorNotes(appointmentId: appointmentId),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatientInformationPanel extends StatelessWidget {
  const PatientInformationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientInfoBloc, PatientInfoState>(
      builder: (context, state) {
        if (state is PatientInfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PatientInfoLoaded) {
          final patientData = state.appointmentDetails;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Patient Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildReadOnlyField(
                    context,
                    label: 'Full Name',
                    value:
                        '${patientData['first_name']} ${patientData['last_name']}',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildReadOnlyField(
                          context,
                          label: 'Date of Birth',
                          value: _formatDate(patientData['date_of_birth']),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildReadOnlyField(
                          context,
                          label: 'Gender',
                          value: patientData['gender'],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildReadOnlyField(
                        context,
                        label: 'Blood Type',
                        value: patientData['blood_type'],
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildReadOnlyField(
                          context,
                          label: 'Height',
                          value: '${patientData['height']} cm',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildReadOnlyField(
                          context,
                          label: 'Weight',
                          value: '${patientData['weight']} kg',
                        ),
                      ),
                    ],
                  ),
                  _buildReadOnlyField(
                    context,
                    label: 'Allergies',
                    value: patientData['allergies'].isEmpty
                        ? 'None'
                        : patientData['allergies'].join(', '),
                  ),
                  _buildReadOnlyField(
                    context,
                    label: 'Medical History',
                    value: patientData['medical_history'].isEmpty
                        ? 'No history available'
                        : patientData['medical_history'].join(', '),
                  ),
                  _buildReadOnlyField(
                    context,
                    label: 'Contact Details',
                    value: patientData['emergency_contact'].isEmpty
                        ? 'No emergency contact provided'
                        : patientData['emergency_contact'].join(', '),
                  ),
                  _buildReadOnlyField(
                    context,
                    label: 'Description',
                    value: patientData['description'] ?? 'No description added',
                    height: 100,
                  ),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(
    BuildContext context, {
    required String label,
    required String value,
    double height = 60,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(13),
              color: Colors.grey[100],
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return "N/A";
    final date = DateTime.parse(timestamp);
    return DateFormat('yyyy-MM-dd').format(date); // Format to show only date.
  }
}

class DoctorNotes extends StatefulWidget {
  final String appointmentId;
  const DoctorNotes({Key? key, required this.appointmentId}) : super(key: key);

  @override
  _DoctorNotesState createState() => _DoctorNotesState();
}

class _DoctorNotesState extends State<DoctorNotes> {
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();
  final TextEditingController prescriptionsController = TextEditingController();
  final Map<String, String> errors = {};

  bool validateFields() {
    bool isValid = true;
    errors.clear();

    if (symptomsController.text.trim().isEmpty) {
      errors['symptoms'] = "Symptoms cannot be empty";
      isValid = false;
    }
    if (diagnosisController.text.trim().isEmpty) {
      errors['diagnosis'] = "Diagnosis cannot be empty";
      isValid = false;
    }
    if (prescriptionsController.text.trim().isEmpty) {
      errors['prescriptions'] = "Prescriptions cannot be empty";
      isValid = false;
    }

    setState(() {}); // Update the UI to display errors
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Doctor\'s Notes:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Symptoms Field
            LabelAndTextField(
              context: context,
              label: "Symptoms",
              hintText: "Enter symptoms here...",
              controller: symptomsController,
              errorText: errors['symptoms'] ?? '',
            ),

            // Diagnosis Field
            LabelAndTextField(
              context: context,
              label: "Diagnosis",
              hintText: "Enter diagnosis here...",
              controller: diagnosisController,
              errorText: errors['diagnosis'] ?? '',
            ),
            // Prescriptions Field
            LabelAndTextField(
              context: context,
              label: "Prescriptions",
              hintText: "Enter prescriptions, separated by comma...",
              controller: prescriptionsController,
              errorText: errors['prescriptions'] ?? '',
              height: 150,
            ),

            CommonButton(
              onTap: () {
                if (validateFields()) {
                  final symptoms = symptomsController.text.trim();
                  final diagnosis = diagnosisController.text.trim();
                  final prescriptionsText = prescriptionsController.text.trim();

                  List<String> prescriptions = prescriptionsText
                      .split(',')
                      .map((e) => e.trim())
                      .toList();

                  context.read<DoctorNotesBloc>().add(
                        AddDoctorNoteEvent(
                          appointmentId: widget.appointmentId,
                          symptoms: symptoms,
                          diagnosis: diagnosis,
                          prescriptions: prescriptions,
                        ),
                      );
                }
              },
              buttonText: 'Finish Examination',
            ),
          ],
        );
      },
    );
  }
}
