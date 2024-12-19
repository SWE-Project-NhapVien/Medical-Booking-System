import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentDataProvider {
  Future<List<dynamic>> getAppointmentData({required String typeAppointment}) async {
    try {
      SupabaseClient supabase = Supabase.instance.client;
      return await supabase.rpc('test_doctor_read_appointment',
          params: {'type_appointment': typeAppointment, 'current_doctor_id': '00000000-0000-0000-0000-000000000002'});
    } catch (e) {
      throw e.toString();
    }
  }
}
