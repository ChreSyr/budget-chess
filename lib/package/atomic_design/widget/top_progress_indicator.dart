import 'package:flutter/material.dart';

class TopProgressIndicator extends StatelessWidget {
  /// Shows a LinearProgressIndicator when loading is true, on top of the given
  /// widget. Perfect for the body of a Scaffold.
  const TopProgressIndicator({
    required this.loading,
    required this.child,
    super.key,
  });

  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(child: child),
        if (loading) const LinearProgressIndicator(),
      ],
    );
  }
}
