import 'package:crea_chess/package/atomic_design/flutter_chat_ui/chat_l10n.dart';
import 'package:flutter/widgets.dart';

// TODO : remove

/// Used to make provided [ChatL10n] class available through the whole package.
class InheritedL10n extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [ChatL10n] class.
  const InheritedL10n({
    required this.l10n,
    required super.child,
    super.key,
  });

  static InheritedL10n of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedL10n>()!;

  /// Represents localized copy.
  final ChatL10n l10n;

  @override
  bool updateShouldNotify(InheritedL10n oldWidget) =>
      l10n.hashCode != oldWidget.l10n.hashCode;
}
