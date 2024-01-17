import 'package:crea_chess/package/chat/flutter_chat_ui/chat_theme.dart';
import 'package:flutter/widgets.dart';

/// Used to make provided [ChatTheme] class available through the whole package.
class InheritedChatTheme extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [ChatTheme] class.
  const InheritedChatTheme({
    required this.theme,
    required super.child,
    super.key,
  });

  static InheritedChatTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedChatTheme>()!;

  /// Represents chat theme.
  final ChatTheme theme;

  @override
  bool updateShouldNotify(InheritedChatTheme oldWidget) =>
      theme.hashCode != oldWidget.theme.hashCode;
}
