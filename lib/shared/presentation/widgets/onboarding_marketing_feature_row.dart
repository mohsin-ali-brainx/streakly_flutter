import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';

/// Label + body row inside onboarding feature cards (Figma “MINDSET” rows).
class OnboardingMarketingFeatureRow extends StatelessWidget {
  const OnboardingMarketingFeatureRow({
    super.key,
    required this.circleColor,
    required this.labelColor,
    required this.label,
    required this.body,
    required this.icon,
    required this.iconColor,
  });

  final Color circleColor;
  final Color labelColor;
  final String label;
  final String body;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: labelColor,
                  height: 15 / 10,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.notificationsInk,
                  height: 24 / 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
