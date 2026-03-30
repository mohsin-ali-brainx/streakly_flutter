import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Radial scrims + soft blur orbs (Figma onboarding marketing screens).
class OnboardingCreamBackdrop extends StatelessWidget {
  const OnboardingCreamBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.35,
                colors: [
                  AppColors.notificationsRadialBrown,
                  Colors.transparent,
                ],
                stops: const [0, 0.55],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.bottomRight,
                radius: 1.35,
                colors: [AppColors.notificationsRadialTeal, Colors.transparent],
                stops: const [0, 0.55],
              ),
            ),
          ),
        ),
        _BlurOrb(
          color: AppColors.notificationsBlobMint.withValues(alpha: 0.2),
          alignment: Alignment.topRight,
          offset: const Offset(96, -96),
        ),
        _BlurOrb(
          color: AppColors.notificationsBlobPeach.withValues(alpha: 0.2),
          alignment: Alignment.bottomLeft,
          offset: const Offset(-96, 96),
        ),
      ],
    );
  }
}

class _BlurOrb extends StatelessWidget {
  const _BlurOrb({
    required this.color,
    required this.alignment,
    required this.offset,
  });

  final Color color;
  final Alignment alignment;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Align(
          alignment: alignment,
          child: Transform.translate(
            offset: offset,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
              child: Container(
                width: 384,
                height: 384,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
