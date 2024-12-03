import 'package:intl/intl.dart';

class DateHelper {
  static final _monthFormat = DateFormat('MMMM yyyy');
  static final _dayFormat = DateFormat('MMM dd');
  static final _fullDayFormat = DateFormat('EEEE, MMMM dd, yyyy');
  static final _timeFormat = DateFormat('hh:mm a');

  /// Formats a date to "Month Year" format (e.g., "January 2024")
  static String formatMonth(DateTime date) {
    return _monthFormat.format(date);
  }

  /// Formats a date to "MMM dd" format (e.g., "Jan 15")
  static String formatDay(DateTime date) {
    return _dayFormat.format(date);
  }

  /// Formats a date to full format (e.g., "Monday, January 15, 2024")
  static String formatFullDate(DateTime date) {
    return _fullDayFormat.format(date);
  }

  /// Formats time to "hh:mm AM/PM" format
  static String formatTime(DateTime date) {
    return _timeFormat.format(date);
  }

  /// Gets a list of unique months from a list of dates
  static List<String> getAvailableMonths(List<DateTime> dates) {
    if (dates.isEmpty) return [];

    final months = dates.map((date) => formatMonth(date)).toSet().toList();
    months.sort((a, b) {
      final aDate = _monthFormat.parse(a);
      final bDate = _monthFormat.parse(b);
      return aDate.compareTo(bDate);
    });
    return months;
  }

  /// Checks if two dates are in the same month and year
  static bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  /// Gets the start of the month for a given date
  static DateTime getMonthStart(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Gets the end of the month for a given date
  static DateTime getMonthEnd(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  /// Gets the date range for a given month string (e.g., "January 2024")
  static DateRange getMonthRange(String monthStr) {
    final date = _monthFormat.parse(monthStr);
    return DateRange(
      start: getMonthStart(date),
      end: getMonthEnd(date),
    );
  }

  /// Calculates the growth rate between two values
  static double calculateGrowthRate(num previous, num current) {
    if (previous == 0) return 0;
    return ((current - previous) / previous) * 100;
  }

  /// Gets the week number of a date
  static int getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysOffset = firstDayOfYear.weekday - 1;
    final firstWeek = (DateTime(date.year, 1, 7 - daysOffset));
    final daysDiff = date.difference(firstWeek).inDays;
    return 1 + ((daysDiff + 7) ~/ 7);
  }
}

/// Represents a date range with start and end dates
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange({required this.start, required this.end});

  bool contains(DateTime date) {
    return date.isAtSameMomentAs(start) ||
        date.isAtSameMomentAs(end) ||
        (date.isAfter(start) && date.isBefore(end));
  }

  Duration get duration => end.difference(start);
}
