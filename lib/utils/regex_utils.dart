class RegexUtils {
  // Add your regex patterns as static constants
  static final RegExp alphabeticCharacters = RegExp(r'[a-zA-Z ]');
  static final RegExp specialCharactersRestriction = RegExp("[0-9a-zA-Z]");
  static final RegExp referralCharactersRestriction = RegExp("[0-9A-Z-]");
  static final RegExp number = RegExp(r'[0-9]');
  static final RegExp mobileNumber = RegExp(r'^[6-9]');
  static final RegExp email = RegExp(r'[a-zA-Z0-9@._-]');

  static RegExp decimalRestriction(int allowDecimalCount) => RegExp('^\\d*\\.?\\d{0,$allowDecimalCount}');

  static RegExp decimalZeroRestriction(int allowDecimalCount) =>
      RegExp(r'^(0|[1-9]\d*)(\.\d{0,' + allowDecimalCount.toString() + r'})?$');
}
