import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';

class NotFoundScreen extends StatelessWidget {
  final VoidCallback? onGoHome;
  final String? title;
  final String? message;

  const NotFoundScreen({
    super.key,
    this.onGoHome,
    this.title = 'Page Not Found',
    this.message = "The page you're looking for\ndoesn't exist.",
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
              // 404 Text
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ).createShader(bounds),
                child: const Text(
                  '404',
                  style: TextStyle(
                    fontSize: 96,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -4,
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.search_off_rounded,
                    size: 42, color: AppColors.secondary),
              ),
              const SizedBox(height: AppDimensions.lg),
              Text(title!,
                  style: AppTextStyles.headlineSmall,
                  textAlign: TextAlign.center),
              const SizedBox(height: AppDimensions.sm),
              Text(message!,
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.grey500),
                  textAlign: TextAlign.center),
              if (onGoHome != null) ...[
                const SizedBox(height: AppDimensions.xl),
                ElevatedButton.icon(
                  onPressed: onGoHome,
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Go to Home'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
