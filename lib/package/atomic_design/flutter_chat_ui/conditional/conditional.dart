import 'package:crea_chess/package/atomic_design/flutter_chat_ui/conditional/conditional_stub.dart'
    if (dart.library.io) 'io_conditional.dart'
    if (dart.library.html) 'browser_conditional.dart';
import 'package:flutter/material.dart';

/// The abstract class for a conditional import feature.
abstract class Conditional {
  /// Creates a new platform appropriate conditional.
  ///
  /// Creates an `IOConditional` if `dart:io` is available and a
  /// `BrowserConditional` if `dart:html` is available,
  /// otherwise it will throw an unsupported error.
  factory Conditional() => createConditional();

  /// Returns an appropriate platform ImageProvider for specified URI.
  ImageProvider getProvider(String uri, {Map<String, String>? headers});
}
