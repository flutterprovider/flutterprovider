import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

class ErrorScreen extends StatelessWidget {
  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onRetry;
  final Widget? illustration;

  const ErrorScreen({
    super.key,
    this.title = 'Something Went Wrong',
    this.message = 'An unexpected error occurred.\nPlease try again.',
    this.buttonText = 'Try Again',
    this.onRetry,
    this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              illustration ??
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.error_outline_rounded,
                        size: 64, color: AppColors.error),
                  ),
              const SizedBox(height: AppDimensions.xl),
              Text(title!,
                  style: AppTextStyles.headlineSmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppDimensions.sm),
              Text(message!,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.grey500),
                  textAlign: TextAlign.center),
              if (onRetry != null) ...[
                const SizedBox(height: AppDimensions.xl),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(buttonText!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
