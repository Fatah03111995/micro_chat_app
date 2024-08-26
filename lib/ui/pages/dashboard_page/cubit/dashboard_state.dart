import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int indexPage;
  const DashboardState({this.indexPage = 0});

  @override
  List<Object?> get props => [indexPage];
}
