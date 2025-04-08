import 'package:lifequest/features/habits/domain/enums/habit_frequency.dart';

bool isSameDate(DateTime? storedDate, HabitFrequency frequency) {
  if (storedDate == null) return false;

  try {
    final now = DateTime.now();

    switch (frequency) {
      case HabitFrequency.twiceADay:
        final sameDay = storedDate.year == now.year &&
            storedDate.month == now.month &&
            storedDate.day == now.day;

        final isMorningNow = now.hour < 12;
        final isMorningStored = storedDate.hour < 12;

        return sameDay && (isMorningNow == isMorningStored);

      case HabitFrequency.daily:
        return storedDate.year == now.year &&
            storedDate.month == now.month &&
            storedDate.day == now.day;

      case HabitFrequency.weekly:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 6));
        final endOfWeek = startOfWeek.add(const Duration(days: 1));

        return !storedDate.isBefore(startOfWeek) &&
            !storedDate.isAfter(endOfWeek);

      case HabitFrequency.biweekly:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 13));
        final endOfWeek = startOfWeek.add(const Duration(days: 1));

        return !storedDate.isBefore(startOfWeek) &&
            !storedDate.isAfter(endOfWeek);

      case HabitFrequency.monthly:
        return storedDate.year == now.year && storedDate.month == now.month;
    }
  } catch (e) {
    return false;
  }
}
