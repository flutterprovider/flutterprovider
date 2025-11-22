import 'package:flutter/material.dart';

/// BuildContext के लिए एक्सटेंशन, जिससे Theme और Media Query data आसानी से एक्सेस किया जा सके।
extension ContextExtensions on BuildContext {
  // -------------------------
  // 1. Theme (रंग और टेक्स्ट स्टाइल एक्सेस करने के लिए)
  // -------------------------

  /// ThemeData ऑब्जेक्ट रिटर्न करता है।
  ThemeData get theme => Theme.of(this);

  /// TextTheme ऑब्जेक्ट रिटर्न करता है (आमतौर पर टेक्स्ट साइज़ और स्टाइल के लिए)।
  TextTheme get textTheme => theme.textTheme;

  /// ColorScheme ऑब्जेक्ट रिटर्न करता है (आमतौर पर प्राथमिक रंग एक्सेस करने के लिए)।
  ColorScheme get colorScheme => theme.colorScheme;

  // -------------------------
  // 2. Media Query (स्क्रीन साइज़ एक्सेस करने के लिए)
  // -------------------------

  /// MediaQueryData ऑब्जेक्ट रिटर्न करता है।
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// स्क्रीन की कुल चौड़ाई (width) रिटर्न करता है।
  double get screenWidth => mediaQuery.size.width;

  /// स्क्रीन की कुल ऊँचाई (height) रिटर्न करता है।
  double get screenHeight => mediaQuery.size.height;

  /// वह Padding (जैसे Notch/Status Bar) रिटर्न करता है जिसे UI से बचना चाहिए।
  EdgeInsets get viewPadding => mediaQuery.padding;

  // -------------------------
  // 3. Navigation (नेविगेशन को आसान बनाने के लिए)
  // -------------------------

  /// Navigator को Push() करने का आसान तरीका।
  Future<T?> push<T extends Object?>(Widget route) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => route),
    );
  }

  /// वर्तमान स्क्रीन को Pop() करने का आसान तरीका।
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}


/// use case
/// Theme एक्सेस करने के लिए
// Color primaryColor = Theme.of(context).colorScheme.primary;

/// Width एक्सेस करने के लिए
// double width = MediaQuery.of(context).size.width;

/// Theme एक्सेस करने के लिए
// Color primaryColor = context.colorScheme.primary;

/// Width एक्सेस करने के लिए
// double width = context.screenWidth;

/// नेविगेशन के लिए
// context.push(NextScreen());