import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int dummyTextMultiplier;

  const CenterText(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.overflow = TextOverflow.ellipsis,
    this.dummyTextMultiplier = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text * dummyTextMultiplier,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
