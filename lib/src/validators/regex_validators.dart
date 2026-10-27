class RegexValidators {
  RegexValidators._();

  static final RegExp email = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$');
  static final RegExp phone = RegExp(r'^\+?[0-9]{10,15}$');
  static final RegExp url = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$', caseSensitive: false);
  static final RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
  static final RegExp alphabetsOnly = RegExp(r'^[a-zA-Z]+$');
  static final RegExp numbersOnly = RegExp(r'^\d+$');
  static final RegExp decimal = RegExp(r'^\d+(\.\d+)?$');
  static final RegExp username = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  static final RegExp pinCode = RegExp(r'^\d{6}$');
  static final RegExp panCard = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  static final RegExp aadhar = RegExp(r'^\d{12}$');
  static final RegExp ipAddress = RegExp(
      r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
  static final RegExp hexColor = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

  static bool isValid(RegExp regex, String value) => regex.hasMatch(value);
}
