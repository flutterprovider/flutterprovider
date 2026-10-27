import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ─── String Extensions ────────────────────────────────────────────────────────
extension StringExtensions on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');

  String get camelToWords =>
      replaceAllMapped(RegExp(r'[A-Z]'), (m) => ' ${m.group(0)}').trim();

  bool get isEmail =>
      RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(this);

  bool get isPhone => RegExp(r'^\+?[0-9]{10,15}$').hasMatch(this);

  bool get isUrl =>
      RegExp(r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$', caseSensitive: false)
          .hasMatch(this);

  bool get isNumeric => RegExp(r'^\d+(\.\d+)?$').hasMatch(this);

  String truncate(int maxLength, {String suffix = '...'}) =>
      length > maxLength ? '${substring(0, maxLength)}$suffix' : this;

  String? get nullIfEmpty => isEmpty ? null : this;

  int toIntOrZero() => int.tryParse(this) ?? 0;
  double toDoubleOrZero() => double.tryParse(this) ?? 0.0;
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  String get orEmpty => this ?? '';
}

// ─── DateTime Extensions ──────────────────────────────────────────────────────
extension DateTimeExtensions on DateTime {
  String format([String pattern = 'dd MMM yyyy']) =>
      DateFormat(pattern).format(this);

  String get toReadable => DateFormat('dd MMM yyyy').format(this);
  String get toReadableWithTime => DateFormat('dd MMM yyyy, hh:mm a').format(this);
  String get toTimeOnly => DateFormat('hh:mm a').format(this);
  String get toIso => toIso8601String();

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(this);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }
}

// ─── BuildContext Extensions ──────────────────────────────────────────────────
extension BuildContextExtensions on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Screen
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  // Navigation
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Widget screen) => Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => screen));
  Future<T?> pushReplacement<T>(Widget screen) =>
      Navigator.of(this).pushReplacement(
          MaterialPageRoute(builder: (_) => screen));
  void pushAndRemoveAll(Widget screen) => Navigator.of(this)
      .pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => screen), (_) => false);

  // Snackbar
  void showSnackbar(String message,
      {Color? backgroundColor, Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showError(String message) =>
      showSnackbar(message, backgroundColor: Colors.red);
  void showSuccess(String message) =>
      showSnackbar(message, backgroundColor: Colors.green);

  // Keyboard
  void hideKeyboard() => FocusScope.of(this).unfocus();
}

// ─── int Extensions ───────────────────────────────────────────────────────────
extension IntExtensions on int {
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);

  String get twoDigits => toString().padLeft(2, '0');

  String get fileSize {
    if (this < 1024) return '${this}B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)}KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }
}

// ─── double Extensions ────────────────────────────────────────────────────────
extension DoubleExtensions on double {
  String get inCurrency => NumberFormat.currency(symbol: '₹').format(this);
  String toFixed(int places) => toStringAsFixed(places);
}

// ─── List Extensions ──────────────────────────────────────────────────────────
extension ListExtensions<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
  List<T> get unique => toSet().toList();
}
