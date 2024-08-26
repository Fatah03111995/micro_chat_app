class DashboardEvent {
  const DashboardEvent();
}

class ChangeIndex extends DashboardEvent {
  final int newIndex;
  const ChangeIndex({required this.newIndex});
}
