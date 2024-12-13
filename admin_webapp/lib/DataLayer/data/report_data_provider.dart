import 'package:supabase_flutter/supabase_flutter.dart';

class ReportDataProvider {
  Future<(int totalAccount, List<dynamic> appointments)>
      fetchReportData() async {
    SupabaseClient _supabase = Supabase.instance.client;
    int totalAccount =
        await _supabase.rpc('admin_read_number_of_patient_account') as int;
    List<dynamic> appointments =
        await _supabase.rpc('admin_read_all_sorted_appointment');
    return (totalAccount, appointments);
  }
}
