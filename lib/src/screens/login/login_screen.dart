import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text_styles.dart';
import '../../validators/form_validators.dart';

class LoginScreen extends StatefulWidget {
  final Future<bool> Function(String email, String password) onLogin;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onSignUp;
  final String? logoAsset;
  final String appName;
  final Color? primaryColor;

  const LoginScreen({
    super.key,
    required this.onLogin,
    this.onForgotPassword,
    this.onSignUp,
    this.logoAsset,
    this.appName = 'My App',
    this.primaryColor,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final success = await widget.onLogin(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (!success && mounted) {
        setState(() => _errorMessage = 'Invalid credentials. Please try again.');
      }
    } catch (e) {
      if (mounted) setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = widget.primaryColor ?? AppColors.primary;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.pageHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.xxxl),

              // Logo / App Name
              Center(
                child: Column(
                  children: [
                    if (widget.logoAsset != null)
                      Image.asset(widget.logoAsset!, height: 80)
                    else
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusXl),
                        ),
                        child: Icon(Icons.apps_rounded, size: 40, color: primary),
                      ),
                    const SizedBox(height: AppDimensions.md),
                    Text(widget.appName,
                        style: AppTextStyles.headlineMedium),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.xxxl),

              Text('Welcome Back 👋',
                  style: AppTextStyles.headlineSmall),
              const SizedBox(height: AppDimensions.xs),
              Text('Sign in to continue',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.grey500)),

              const SizedBox(height: AppDimensions.xl),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: FormValidators.email,
                    ),

                    const SizedBox(height: AppDimensions.md),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: FormValidators.password,
                    ),

                    const SizedBox(height: AppDimensions.sm),

                    // Forgot Password
                    if (widget.onForgotPassword != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: widget.onForgotPassword,
                          child: const Text('Forgot Password?'),
                        ),
                      ),

                    // Error Message
                    if (_errorMessage != null) ...[
                      const SizedBox(height: AppDimensions.sm),
                      Container(
                        padding: const EdgeInsets.all(AppDimensions.sm),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSm),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline,
                                color: AppColors.error, size: 18),
                            const SizedBox(width: AppDimensions.sm),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: AppTextStyles.bodySmall
                                    .copyWith(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: AppDimensions.xl),

                    // Login Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Login'),
                    ),

                    const SizedBox(height: AppDimensions.md),

                    // Sign Up
                    if (widget.onSignUp != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: AppTextStyles.bodyMedium),
                          TextButton(
                            onPressed: widget.onSignUp,
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
