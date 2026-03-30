import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Glass ring + gradient disc + optional corner badge (notifications bell, insurance shield, etc.).
class OnboardingGlassCircleHero extends StatelessWidget {
  const OnboardingGlassCircleHero({
    super.key,
    required this.icon,
    this.size = 192,
    this.centerIconSize = 40,
    this.frameBackgroundColor = AppColors.notificationsScreenBg,
  });

  final IconData icon;
  final double size;
  final double centerIconSize;

  /// Badge ring “cutout” matches screen background.
  final Color frameBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.3),
                  border: Border.all(color: AppColors.notificationsGlassBorder),
                ),
                child: Center(
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.notificationsHeroInner,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          offset: const Offset(0, 12),
                          color: const Color(0x1485736D),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.notificationsCtaBrown,
                              AppColors.notificationsHeroGradientEnd,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(0, 10),
                              color: Color(0x1A000000),
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: centerIconSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -8,
            bottom: -8,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.notificationsBadgeTeal,
                border: Border.all(color: frameBackgroundColor, width: 4),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_fire_department_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
