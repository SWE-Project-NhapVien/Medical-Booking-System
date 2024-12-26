import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_all_doctors_event.dart';
part 'get_all_doctors_state.dart';

class GetAllDoctorsBloc extends Bloc<GetAllDoctorsEvent, GetAllDoctorsState> {
  GetAllDoctorsBloc() : super(GetAllDoctorsInitial()) {
    on<GetAllDoctorsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
