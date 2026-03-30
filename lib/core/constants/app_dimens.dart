import 'package:flutter/material.dart';

/// Spacing, radii, and touch targets shared across the app.
abstract final class AppDimens {
  AppDimens._();

  static const double radiusSm = 16;
  static const double radiusMd = 22;
  static const double radiusLg = 28;

  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 10;
  static const double spaceLg = 12;
  static const double spaceXl = 14;
  static const double space2xl = 16;
  static const double space3xl = 18;
  static const double sectionGap = 22;
  static const double space4xl = 24;
  static const double space5xl = 28;

  /// Horizontal padding for onboarding / page content.
  static const double pagePaddingH = 20;
  static const double pagePaddingHLoose = 24;

  static const double primaryButtonHeight = 56;
  static const double onboardingProgressRing = 40;
  static const double progressStroke = 6;
  static const double smallProgressStroke = 2.5;
  static const double smallProgressSize = 22;

  static const EdgeInsets onboardingHeaderPadding =
      EdgeInsets.fromLTRB(pagePaddingH, 14, pagePaddingH, 0);
  static const EdgeInsets onboardingHeaderPaddingLoose =
      EdgeInsets.fromLTRB(pagePaddingH, spaceSm, pagePaddingHLoose, 0);
  static const EdgeInsets onboardingBodyPadding =
      EdgeInsets.fromLTRB(pagePaddingH, 0, pagePaddingH, space2xl);

  static const double gridCrossAxisSpacing = 14;
  static const double gridMainAxisSpacing = 14;
}
