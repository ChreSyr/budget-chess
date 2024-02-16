import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class CCGap {
  /// Gap(2)
  static const zero = SizedBox.shrink();

  /// Gap(2)
  static const xxsmall = Gap(CCSize.xxsmall);

  /// Gap(4)
  static const xsmall = Gap(CCSize.xsmall);

  /// Gap(8)
  static const small = Gap(CCSize.small);

  /// Gap(16)
  static const medium = Gap(CCSize.medium);

  /// Gap(24)
  static const large = Gap(CCSize.large);

  /// Gap(32)
  static const xlarge = Gap(CCSize.xlarge);

  /// Gap(48)
  static const xxlarge = Gap(CCSize.xxlarge);

  /// Gap(64)
  static const xxxlarge = Gap(CCSize.xxxlarge);
}
