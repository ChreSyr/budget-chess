import 'dart:math';

import 'package:flutter/material.dart';

class CCSize {
  /// 2.0
  static const xxsmall = 2.0;

  /// 4.0
  static const xsmall = 4.0;

  /// 8.0
  static const small = 8.0;

  /// 16.0
  static const medium = 16.0;

  /// 24.0
  static const large = 24.0;

  /// 32.0
  static const xlarge = 32.0;

  /// 48.0
  static const xxlarge = 48.0;

  /// 64.0
  static const xxxlarge = 64.0;

  static double boardSizeOf(BuildContext context) =>
      min(MediaQuery.of(context).size.width, CCWidgetSize.large4);
}

class CCWidgetSize {
  /// 48.0
  static const xxxsmall = 48.0;

  /// 64.0
  static const xxsmall = 64.0;

  /// 80.0
  static const xsmall = 80.0;

  /// 96.0
  static const small = 96.0;

  /// 112.0
  static const medium = 112.0;

  /// 128.0
  static const large = 128.0;

  /// 144.0
  static const xlarge = 144.0;

  /// 144.0
  static const xxlarge = 160.0;

  /// 176.0
  static const xxxlarge = 176.0;

  /// 128.0 x 2 = 256.0
  static const large2 = 256.0;

  /// 128.0 x 4 = 512.0
  static const large4 = 512.0;
}
