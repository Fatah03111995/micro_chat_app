import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/ui/pages/dashboard_page/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void changeIndex(int newIndex) {
    emit(DashboardState(indexPage: newIndex));
  }
}
