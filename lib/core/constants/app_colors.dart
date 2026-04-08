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

  // —— Habits list & create / edit sheet (Figma habit UI ~191:432, ~191:601) ——
  static const Color habitsScreenBg = Color(0xFFFBF9F4);
  static const Color habitsTitleInk = Color(0xFF1B1C19);
  static const Color habitsBodyBrown = Color(0xFF53433E);
  static const Color habitsMuted = Color(0xFF85736D);
  static const Color habitsCardTint = Color(0xFFF5F3EE);
  /// rgba(164, 100, 77, 0.10)
  static const Color habitsIconWellFill = Color(0x1AA4644D);
  static const Color habitsPrimaryCta = Color(0xFF874C36);
  /// rgba(186, 26, 26, 0.70)
  static const Color habitsArchiveInk = Color(0xB3BA1A1A);

  // —— Today tab (Figma ~191:255, same file as Habits / habit detail) ——
  static const Color todayScreenBg = habitsScreenBg;
  static const Color todayTealDone = Color(0xFF1A6660);
  static const Color todayCheckRing = Color(0xFFD8C2BB);
  static const Color todayInsuranceCardBg = Color(0xFFE4E2DD);
  /// rgba(216, 194, 187, 0.15)
  static const Color todayInsuranceBorder = Color(0x26D8C2BB);

  static const Color bottomNavBarBg = Color(0xFFFFFFFF);
  static const Color bottomNavInactive = Color(0xFFD8C2BB);

  static const Color todayProgressCardBg = Color(0xFFF3EEE6);
  static const Color todayInsuranceCardGrey = Color(0xFFE8E6E1);
  static const Color todayInsightMint = Color(0xFFE4EFE4);
  static const Color todayHabitDoneGreen = Color(0xFF2D5A47);
  static const Color todayWellMeditate = Color(0xFFE4EDE4);
  static const Color todayWellRead = Color(0xFFFFF2E8);
  static const Color todayWellWalk = Color(0xFFEAE8E6);
  static const Color todayWellWater = Color(0xFFE3F2FA);
  static const Color todayWellJournal = Color(0xFFF0EBFA);

  static const Color statsLongestStreakBg = Color(0xFF4E342E);
  static const Color statsDiversityCardBg = Color(0xFFF0EDE8);
  static const Color statsConsistencyBg = Color(0xFF1A5A52);
  static const Color statsWeeklyLegendMuted = Color(0xFFE8E4DE);

  static const Color habitEditorScreenBg = Color(0xFFFDFBF7);
  static const Color visualAnchorCardBg = Color(0xFFF7F4F0);
  static const Color visualAnchorInactiveWell = Color(0xFFE8E6E1);
  static const Color visualAnchorSelected = Color(0xFF7D523F);
  static const Color visualAnchorIconBrown = Color(0xFF5C4D42);
}
