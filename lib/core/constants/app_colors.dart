import 'package:flutter/material.dart';

/// Brand and marketing colors that complement [ThemeData.colorScheme].
abstract final class AppColors {
  AppColors._();

  static const Color logoBrown = Color(0xFF5C4033);
  static const Color welcomeCream = Color(0xFFF9F7F2);
  static const Color welcomeBlob = Color(0xFFE8E4DC);
  static const Color ink = Color(0xFF2D2A28);
  static const Color inkMuted = Color(0xFF6D6560);
  static const Color tealLabel = Color(0xFF418780);
  static const Color mutedGreen = Color(0xFF5F7464);
  static const Color ctaBrown = Color(0xFFAC6B53);
  static const Color skipGrey = Color(0xFFB0A8A0);
  static const Color badgeFill = Color(0xFFF5EBE6);

  // —— Onboarding notifications (Figma “Notifications Permission” 191:206) ——
  static const Color notificationsScreenBg = Color(0xFFFBF9F4);
  static const Color notificationsInk = Color(0xFF1B1C19);
  static const Color notificationsHeadlineAccent = Color(0xFF874C36);
  static const Color notificationsBody = Color(0xFF53433E);
  static const Color notificationsCardBg = Color(0xFFF5F3EE);
  static const Color notificationsCardBorder = Color(0x1AD8C2BB);
  static const Color notificationsGlassBorder = Color(0x26D8C2BB);
  static const Color notificationsMindsetCircle = Color(0xFFCCE3CF);
  static const Color notificationsMindsetLabel = Color(0xFF4F6354);
  static const Color notificationsReliabilityCircle = Color(0xFFA9F0E7);
  static const Color notificationsReliabilityLabel = Color(0xFF1A6660);
  static const Color notificationsCtaBrown = Color(0xFF874C36);
  static const Color notificationsCtaShadow = Color(0x33874C36);
  static const Color notificationsLater = Color(0xFF85736D);
  static const Color notificationsBadgeTeal = Color(0xFF398079);
  static const Color notificationsBlobMint = Color(0xFFCCE3CF);
  static const Color notificationsBlobPeach = Color(0xFFFFB59B);
  static const Color notificationsHeroInner = Color(0xFFF5F3EE);
  static const Color notificationsHeroGradientEnd = Color(0xFFA4644D);
  static const Color notificationsRadialBrown = Color(0x0DA4644D);
  static const Color notificationsRadialTeal = Color(0x0D1A6660);

  /// Third accent row on onboarding insurance card (warm circle).
  static const Color onboardingInsuranceFeatureCircle =
      Color(0xFFFFE8DD);
}
