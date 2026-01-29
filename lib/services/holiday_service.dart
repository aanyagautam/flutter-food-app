class HolidayService {
  static List<DateTime> schoolHolidays = [
    DateTime(2026, 1, 26),  // Republic Day
    DateTime(2026, 3, 1),   // Holi
    DateTime(2026, 3, 15),  // Annual Day
    DateTime(2026, 4, 14),  // Ambedkar Jayanti
    DateTime(2026, 5, 1),   // Labour Day
    DateTime(2026, 8, 15),  // Independence Day
    DateTime(2026, 10, 2),  // Gandhi Jayanti
    DateTime(2026, 10, 20), // Dussehra
    DateTime(2026, 11, 14), // Diwali
    DateTime(2026, 12, 25), // Christmas
  ];

  static bool isSchoolOpen(DateTime date) {
    // Check if it's Sunday
    if (date.weekday == DateTime.sunday) {
      return false;
    }

    // Check if it's a school holiday
    return !schoolHolidays.any((holiday) =>
        holiday.year == date.year &&
        holiday.month == date.month &&
        holiday.day == date.day);
  }

  static bool isSchoolOpenToday() {
    return isSchoolOpen(DateTime.now());
  }

  static DateTime? getNextOpenDay() {
    DateTime current = DateTime.now();
    for (int i = 1; i <= 7; i++) {
      DateTime nextDay = current.add(Duration(days: i));
      if (isSchoolOpen(nextDay)) {
        return nextDay;
      }
    }
    return null;
  }

  static String getHolidayMessage() {
    if (!isSchoolOpenToday()) {
      DateTime? nextOpen = getNextOpenDay();
      if (nextOpen != null) {
        int daysUntil = nextOpen.difference(DateTime.now()).inDays;
        return 'School Closed Today - Ordering Disabled\nNext open day: ${nextOpen.day}/${nextOpen.month}/${nextOpen.year} (in $daysUntil days)';
      }
      return 'School Closed Today - Ordering Disabled';
    }
    return '';
  }
}
