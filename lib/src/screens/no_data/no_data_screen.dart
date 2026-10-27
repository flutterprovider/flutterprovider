import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

class NoDataScreen extends StatelessWidget {
  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onAction;
  final Widget? illustration;
  final IconData icon;

  const NoDataScreen({
    super.key,
    this.title = 'No Data Found',
    this.message = 'There is nothing to show here yet.',
    this.buttonText,
    this.onAction,
    this.illustration,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    color: AppColors.primary.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 64, color: AppColors.primary.withOpacity(0.5)),
                ),
            const SizedBox(height: AppDimensions.xl),
            Text(title!,
                style: AppTextStyles.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: AppDimensions.sm),
            Text(message!,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.grey500),
                textAlign: TextAlign.center),
            if (onAction != null && buttonText != null) ...[
              const SizedBox(height: AppDimensions.xl),
              ElevatedButton(
                onPressed: onAction,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
