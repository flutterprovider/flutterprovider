class FormValidators {
  FormValidators._();

  // ─── Required ─────────────────────────────────────────────────────────────
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  // ─── Email ────────────────────────────────────────────────────────────────
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  // ─── Password ─────────────────────────────────────────────────────────────
  static String? password(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'At least 8 characters required';
    if (!value.contains(RegExp(r'[A-Z]'))) return 'Include an uppercase letter';
    if (!value.contains(RegExp(r'[a-z]'))) return 'Include a lowercase letter';
    if (!value.contains(RegExp(r'[0-9]'))) return 'Include a number';
    if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return 'Include a special character';
    }
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != original) return 'Passwords do not match';
    return null;
  }

  // ─── Phone ────────────────────────────────────────────────────────────────
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) return 'Enter a valid phone number';
    return null;
  }

  // ─── Name ─────────────────────────────────────────────────────────────────
  static String? name(String? value, {int minLength = 2}) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (value.trim().length < minLength) {
      return 'Name must be at least $minLength characters';
    }
    return null;
  }

  // ─── URL ──────────────────────────────────────────────────────────────────
  static String? url(String? value) {
    if (value == null || value.isEmpty) return 'URL is required';
    final regex = RegExp(
        r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
        caseSensitive: false);
    if (!regex.hasMatch(value)) return 'Enter a valid URL';
    return null;
  }

  // ─── Number ───────────────────────────────────────────────────────────────
  static String? number(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (double.tryParse(value) == null) return 'Enter a valid number';
    return null;
  }

  static String? minValue(String? value, double min) {
    final err = number(value);
    if (err != null) return err;
    if (double.parse(value!) < min) return 'Value must be at least $min';
    return null;
  }

  static String? maxValue(String? value, double max) {
    final err = number(value);
    if (err != null) return err;
    if (double.parse(value!) > max) return 'Value must not exceed $max';
    return null;
  }

  // ─── Length ───────────────────────────────────────────────────────────────
  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    if (value.length < min) return 'Minimum $min characters required';
    return null;
  }

  static String? maxLength(String? value, int max) {
    if (value != null && value.length > max) {
      return 'Maximum $max characters allowed';
    }
    return null;
  }

  // ─── OTP / PIN ────────────────────────────────────────────────────────────
  static String? otp(String? value, {int length = 6}) {
    if (value == null || value.isEmpty) return 'OTP is required';
    if (value.length != length) return 'Enter $length digit OTP';
    if (!RegExp(r'^\d+$').hasMatch(value)) return 'OTP must be numeric';
    return null;
  }

  // ─── Combine multiple validators ──────────────────────────────────────────
  static String? Function(String?) combine(
      List<String? Function(String?)> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}
