import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_event.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<ChangeIndex>(_changeIndexHandler);
  }

  void _changeIndexHandler(ChangeIndex event, Emitter emit) {
    emit(DashboardState(indexPage: event.newIndex));
  }
}
