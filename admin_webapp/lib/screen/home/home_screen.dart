import 'package:admin_webapp/bloc/CreateNewAccount/create_new_account_bloc.dart';
import 'package:admin_webapp/bloc/GetAllDoctors/get_all_doctors_bloc.dart';
import 'package:admin_webapp/bloc/GetAllPatients/get_all_patients_bloc.dart';
import 'package:admin_webapp/bloc/GetDoctorSchedule/get_doctor_schedule_bloc.dart';
import 'package:admin_webapp/bloc/UpdateDoctorSchedule/update_doctor_schedule_bloc.dart';
import 'package:admin_webapp/class/doctor.dart';
import 'package:admin_webapp/class/patient.dart';
import 'package:admin_webapp/routes/navigation_services.dart';
import 'package:admin_webapp/screen/home/add_new_doctor.dart';
import 'package:admin_webapp/screen/home/doctor_detailed_information.dart';
import 'package:admin_webapp/screen/home/doctor_information_card.dart';
import 'package:admin_webapp/screen/home/patient_detailed_information.dart';
import 'package:admin_webapp/screen/home/patient_information_card.dart';
import 'package:admin_webapp/utils/color_palette.dart';
import 'package:admin_webapp/utils/fixed_web_component.dart';
import 'package:admin_webapp/utils/text_styles.dart';
import 'package:admin_webapp/widgets/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> patients = [];
  List<Map<String, dynamic>> doctors = [];

  bool showPatientDetailedInfo = false;
  bool showDoctorDetailedInfo = false;

  Patient? selectedPatient;
  Doctor? selectedDoctor;

  @override
  void initState() {
    context.read<GetAllPatientsBloc>().add(const GetAllPatientsEvent());
    context.read<GetAllDoctorsBloc>().add(const GetAllDoctorsEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextStyle tabStyle =
        TextStyles(context).getRegularStyle(fontWeight: FontWeight.w400);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateNewAccountBloc(),
          ),
          BlocProvider(
            create: (context) => GetDoctorScheduleBloc(),
          ),
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<GetAllPatientsBloc, GetAllPatientsState>(
                listener: (context, state) async {
                  if (state is GetAllPatientsLoading) {
                    await Dialogs(context).showLoadingDialog();
                  } else if (state is GetAllPatientsSuccessfully) {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                    setState(() {
                      patients = state.patients;
                    });
                  } else if (state is GetAllPatientsFailure) {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                    Dialogs(context).showErrorDialog(message: state.error);
                  }
                },
              ),
              BlocListener<GetAllDoctorsBloc, GetAllDoctorsState>(
                listener: (context, state) async {
                  if (state is GetAllDoctorsLoading) {
                    await Dialogs(context).showLoadingDialog();
                  } else if (state is GetAllDoctorsSuccessfully) {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                    setState(() {
                      doctors = state.doctors;
                    });
                    // print('Doctors: $doctors');
                  } else if (state is GetAllDoctorsFailure) {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                    Dialogs(context).showErrorDialog(message: state.error);
                  }
                },
              ),
              BlocListener<UpdateDoctorScheduleBloc, UpdateDoctorScheduleState>(
                listener: (context, state) {
                  if (state is UpdateDoctorScheduleLoading) {
                    Dialogs(context).showLoadingDialog();
                  } else if (state is UpdateDoctorScheduleSuccess) {
                    Navigator.of(context).pop();
                    Dialogs(context).showAnimatedDialog(
                      title: 'Update schedule successfully',
                      content: 'Doctor schedule has been updated successfully',
                    );
                    context.read<GetDoctorScheduleBloc>().add(
                        GetDoctorScheduleRequired(
                            doctorID: selectedDoctor!.doctorID));
                  } else if (state is UpdateDoctorScheduleFailure) {
                    Navigator.of(context).pop();
                    Dialogs(context).showErrorDialog(message: state.error);
                  }
                },
              ),
              BlocListener<CreateNewAccountBloc, CreateNewAccountState>(
                listener: (context, state) {
                  if (state is CreateNewAccountSuccess) {
                    NavigationServices(context)
                        .pushCreateDoctorProfileScreen(state.doctorId);
                  }
                },
              ),
            ],
            child: Scaffold(
              backgroundColor: ColorPalette.mediumBlue,
              body: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: size.height * 0.05 - 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Management",
                        style: TextStyles(context).getTitleStyle(
                            size: 40,
                            color: ColorPalette.deepBlue,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: Row(children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorPalette.whiteColor,
                              ),
                              child: DefaultTabController(
                                  length: 3,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        labelColor: ColorPalette.deepBlue,
                                        labelStyle: tabStyle,
                                        unselectedLabelColor: Colors.grey,
                                        indicatorColor: ColorPalette.deepBlue,
                                        onTap: (index) {
                                          if (index != 1) {
                                            setState(() {
                                              showPatientDetailedInfo = false;
                                              selectedPatient = null;
                                            });
                                          } else if (index != 0) {
                                            setState(() {
                                              showDoctorDetailedInfo = false;
                                              selectedDoctor = null;
                                            });
                                          }
                                        },
                                        tabs: const [
                                          Tab(text: "Doctors"),
                                          Tab(text: "Patients"),
                                          Tab(text: "+ Add New Doctor"),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            Center(child: _allDoctors(size)),
                                            Center(child: _allPatients(size)),
                                            const Center(child: AddNewDoctor()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          if (showPatientDetailedInfo &&
                              selectedPatient != null)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              child: PatientDetailedInformation(
                                fullname: selectedPatient!.fullname,
                                email: selectedPatient!.email,
                                phoneNumber: selectedPatient!.phone,
                                dob: selectedPatient!.dob,
                                address: selectedPatient!.address,
                                avaUrl: selectedPatient!.avaUrl ?? '',
                                allergies: selectedPatient!.allergies ?? [],
                                medicalHistory:
                                    selectedPatient!.medicalHistory ?? [],
                              ),
                            ),
                          if (showDoctorDetailedInfo && selectedDoctor != null)
                            AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                child: DoctorDetailedInformation(
                                  doctorID: selectedDoctor!.doctorID,
                                  fullname: selectedDoctor!.fullname,
                                  avaUrl: selectedDoctor!.avaUrl ?? '',
                                  specialization:
                                      selectedDoctor!.specialization,
                                )),
                        ]),
                      ),
                    ]),
              ),
            )));
  }

  Widget _allPatients(Size size) {
    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientInformationCard(
          name: patient['patient_full_name'],
          email: patient['patient_email'],
          phoneNumber: patient['patient_phone_number'],
          avaUrl: patient['patient_ava_url'] ?? '',
          onTap: () {
            DateTime date = DateTime.parse(patient['patient_dob']);
            String formattedDate = DateFormat('MMMM d, y').format(date);
            setState(() {
              selectedPatient = Patient(
                fullname: patient['patient_full_name'],
                email: patient['patient_email'],
                phone: patient['patient_phone_number'],
                address: patient['patient_address'],
                dob: formattedDate,
                avaUrl: patient['patient_ava_url'],
                allergies: patient['patient_allergies']?.cast<String>(),
                medicalHistory:
                    patient['patient_medical_history']?.cast<String>(),
              );
              showPatientDetailedInfo = true;
            });
          },
        );
      },
    );
  }

  Widget _allDoctors(Size size) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return DoctorInformationCard(
          name: doctor['doctor_full_name'],
          specialization: doctor['doctor_specialization'].cast<String>(),
          phoneNumber: doctor['doctor_phone_number'],
          avaUrl: doctor['doctor_ava_url'] != ''
              ? doctor['doctor_ava_url']
              : FixedWebComponent.defaultPatientAvatar,
          onTap: () {
            setState(() {
              selectedDoctor = Doctor(
                  doctorID: doctor['doctor_id'],
                  fullname: doctor['doctor_full_name'],
                  avaUrl: doctor['doctor_ava_url'],
                  specialization:
                      doctor['doctor_specialization'].cast<String>(),
                  phoneNumber: doctor['doctor_phone_number']);
              showDoctorDetailedInfo = true;
            });
          },
        );
      },
    );
  }
}
