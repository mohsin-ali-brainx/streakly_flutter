import 'package:flutter/material.dart';

/// Small caps section label (onboarding and marketing blocks).
class OnboardingEyebrowText extends StatelessWidget {
  const OnboardingEyebrowText({
    super.key,
    required this.label,
    this.fontSize,
  });

  final String label;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            letterSpacing: 2,
            fontWeight: FontWeight.w800,
            color: cs.tertiary,
            fontSize: fontSize,
          ),
    );
  }
}
