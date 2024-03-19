import 'package:crea_chess/package/atomic_design/size.dart';
import 'package:flutter/material.dart';

class CCPadding extends Padding {
  const CCPadding({
    required super.padding,
    super.key,
    super.child,
  });

  /// padding: const EdgeInsets.all(2),
  factory CCPadding.allXxsmall({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.all(CCSize.xxsmall),
      child: child,
    );
  }

  /// padding: const EdgeInsets.all(4),
  factory CCPadding.allXsmall({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.all(CCSize.xsmall),
      child: child,
    );
  }

  /// padding: const EdgeInsets.all(8),
  factory CCPadding.allSmall({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.all(CCSize.small),
      child: child,
    );
  }

  /// padding: const EdgeInsets.all(16),
  factory CCPadding.allMedium({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.all(CCSize.medium),
      child: child,
    );
  }

  /// padding: const EdgeInsets.all(24),
  factory CCPadding.allLarge({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.all(CCSize.large),
      child: child,
    );
  }

  /// padding: const EdgeInsets.all(32),
  factory CCPadding.allXlarge({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.all(CCSize.xlarge),
      child: child,
    );
  }

  /// padding: const EdgeInsets.all(48),
  factory CCPadding.allXxlarge({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.all(CCSize.xxlarge),
      child: child,
    );
  }

  /// padding: const EdgeInsets.symmetric(horizontal: 2),
  factory CCPadding.horizontalXxsmall({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.symmetric(horizontal: CCSize.xxsmall),
      child: child,
    );
  }

  /// padding: const EdgeInsets.symmetric(horizontal: 4),
  factory CCPadding.horizontalXsmall({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.symmetric(horizontal: CCSize.xsmall),
      child: child,
    );
  }

  /// padding: const EdgeInsets.symmetric(horizontal: 8),
  factory CCPadding.horizontalSmall({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.symmetric(horizontal: CCSize.small),
      child: child,
    );
  }

  /// padding: const EdgeInsets.symmetric(horizontal: 16),
  factory CCPadding.horizontalMedium({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.symmetric(horizontal: CCSize.medium),
      child: child,
    );
  }

  /// padding: const EdgeInsets.symmetric(horizontal: 24),
  factory CCPadding.horizontalLarge({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.symmetric(horizontal: CCSize.large),
      child: child,
    );
  }

  /// padding: const EdgeInsets.symmetric(horizontal: 32),
  factory CCPadding.horizontalXlarge({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.symmetric(horizontal: CCSize.xlarge),
      child: child,
    );
  }

  /// padding: const EdgeInsets.symmetric(horizontal: 48),
  factory CCPadding.horizontalXxlarge({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.symmetric(horizontal: CCSize.xxlarge),
      child: child,
    );
  }

  /// padding: const EdgeInsets.symmetric(vertical: 16),
  factory CCPadding.verticalMedium({required Widget child}) {
    return CCPadding(
      padding: const EdgeInsets.symmetric(vertical: CCSize.medium),
      child: child,
    );
  }
}
