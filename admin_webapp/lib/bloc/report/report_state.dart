import '../../class/report.dart';

sealed class ReportState {}

final class InitReportState extends ReportState {}

final class LoadingReportState extends ReportState {}

final class ErrorReportState extends ReportState {
  final String message;

  ErrorReportState({required this.message});
}

final class SucessReportState extends ReportState {
  final Report report;

  SucessReportState({required this.report});
}
