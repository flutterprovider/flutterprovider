import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String format(DateTime date, [String pattern = 'dd MMM yyyy']) =>
      DateFormat(pattern).format(date);

  static String toReadable(DateTime date) =>
      DateFormat('dd MMM yyyy').format(date);

  static String toReadableWithTime(DateTime date) =>
      DateFormat('dd MMM yyyy, hh:mm a').format(date);

  static String toTimeOnly(DateTime date) =>
      DateFormat('hh:mm a').format(date);

  static String toApiFormat(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  static DateTime? fromString(String date, [String pattern = 'yyyy-MM-dd']) {
    try {
      return DateFormat(pattern).parse(date);
    } catch (_) {
      return null;
    }
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} weeks ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} months ago';
    return '${(diff.inDays / 365).floor()} years ago';
  }

  static int daysBetween(DateTime from, DateTime to) =>
      to.difference(from).inDays.abs();

  static bool isExpired(DateTime date) => date.isBefore(DateTime.now());

  static DateTime get startOfToday =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  static DateTime get endOfToday =>
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
          23, 59, 59);
}
