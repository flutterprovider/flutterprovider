import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

class OfflineScreen extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? title;
  final String? message;

  const OfflineScreen({
    super.key,
    this.onRetry,
    this.title = 'No Internet Connection',
    this.message =
        'Please check your connection\nand try again.',
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
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.wifi_off_rounded,
                    size: 64, color: AppColors.warning),
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
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warning,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
