import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micro_chat_app/core/bloc/theme/theme_cubit.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(darkTheme: false));

  void toogleTheme() {
    emit(ThemeState(darkTheme: !state.darkTheme));
  }
}
