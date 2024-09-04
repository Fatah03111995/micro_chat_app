// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool darkTheme;
  const ThemeState({
    required this.darkTheme,
  });

  @override
  List<Object?> get props => [darkTheme];
}
