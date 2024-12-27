import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentDataProvider {
  Future<List<dynamic>> getAppointmentData(
      {required String typeAppointment}) async {
    try {
      SupabaseClient supabase = Supabase.instance.client;
      return await supabase.rpc('doctor_read_appointment',
          params: {'type_appointment': typeAppointment});
    } catch (e) {
      throw e.toString();
    }
  }
}
