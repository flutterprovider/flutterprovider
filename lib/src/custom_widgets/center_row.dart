import 'package:flutter/material.dart';

class CenterRow extends StatelessWidget {
  final double spacing;
  final MainAxisSize mainAxisSize;
  final List<Widget> children;

  const CenterRow({
    super.key,
    this.spacing = 0,
    this.children = const [],
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: children,
    );
  }
}
