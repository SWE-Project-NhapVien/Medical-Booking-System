import 'package:flutter/material.dart';
import 'common_appointment_item.dart';

class CompleteAppointment extends StatefulWidget {
  const CompleteAppointment({super.key});

  @override
  State<CompleteAppointment> createState() => _CompleteAppointmentState();
}

class _CompleteAppointmentState extends State<CompleteAppointment> {
  final List<AppointmentCard> _list = [
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      doctorImage: '',
      time: '10:00',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
    AppointmentCard(
      doctorName: 'Doctor 1',
      appointmentName: 'Appointment 1',
      date: '2021-10-10',
      time: '10:00',
      doctorImage: '',
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return _list[index];
        },
      ),
    );
  }
}
