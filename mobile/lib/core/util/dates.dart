/// Returns the Monday (00:00) of the week containing [date].
DateTime startOfWeek(DateTime date) {
  final d = DateTime(date.year, date.month, date.day);
  return d.subtract(Duration(days: d.weekday - DateTime.monday));
}

const weekdayLabels = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

String weekdayLabel(DateTime date) => weekdayLabels[date.weekday - DateTime.monday];
