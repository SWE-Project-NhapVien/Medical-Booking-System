import 'package:flutter_bloc/flutter_bloc.dart';

import '../../DataLayer/repository/report_repository.dart';
import '../../class/report.dart';
import 'report_event.dart';
import 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository _reportRepository;

  ReportBloc({required ReportRepository reportRepository})
      : _reportRepository = reportRepository,
        super(InitReportState()) {
    on<RequestReportEvent>(_requestReportEvent);
  }

  void _requestReportEvent(
      RequestReportEvent event, Emitter<ReportState> emit) async {
    emit(LoadingReportState());
    try {
      final Report reportData = await _reportRepository.getReportData();
      emit(SucessReportState(report: reportData));
    } catch (e) {
      emit(ErrorReportState(message: e.toString()));
    }
  }
}
