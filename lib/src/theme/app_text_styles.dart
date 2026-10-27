import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ─── Display ──────────────────────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57, fontWeight: FontWeight.w400, letterSpacing: -0.25);
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45, fontWeight: FontWeight.w400);
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36, fontWeight: FontWeight.w400);

  // ─── Headline ─────────────────────────────────────────────────────────────
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32, fontWeight: FontWeight.w700);
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28, fontWeight: FontWeight.w700);
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24, fontWeight: FontWeight.w600);

  // ─── Title ────────────────────────────────────────────────────────────────
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w600);
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15);
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1);

  // ─── Body ─────────────────────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5);
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25);
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);

  // ─── Label ────────────────────────────────────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1);
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5);
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5);

  // ─── Shorthand Helpers ────────────────────────────────────────────────────
  static const TextStyle button = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5);
  static const TextStyle caption = TextStyle(
    fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grey500);
  static const TextStyle overline = TextStyle(
    fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 1.5);
  static const TextStyle link = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w500,
    color: AppColors.primary, decoration: TextDecoration.underline);
}
