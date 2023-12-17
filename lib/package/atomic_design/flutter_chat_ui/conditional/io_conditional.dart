import 'dart:io';

import 'package:crea_chess/package/atomic_design/flutter_chat_ui/conditional/base_conditional.dart';
import 'package:flutter/material.dart';

/// Create a [IOConditional].
///
/// Used from conditional imports, matches the definition in `conditional_stub.dart`.
BaseConditional createConditional() => IOConditional();

/// A conditional for anything but browser.
class IOConditional extends BaseConditional {
  /// Returns [NetworkImage] if URI starts with http
  /// otherwise uses IO to create File.
  @override
  ImageProvider getProvider(String uri, {Map<String, String>? headers}) {
    if (uri.startsWith('http')) {
      return NetworkImage(uri, headers: headers);
    } else {
      return FileImage(File(uri));
    }
  }
}
