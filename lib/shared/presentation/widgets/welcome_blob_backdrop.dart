import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Large decorative circles used on the welcome screen.
class WelcomeBlobBackdrop extends StatelessWidget {
  const WelcomeBlobBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: -72,
          top: -24,
          child: IgnorePointer(
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.welcomeBlob,
              ),
            ),
          ),
        ),
        Positioned(
          right: -100,
          bottom: 120,
          child: IgnorePointer(
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.welcomeBlob.withValues(alpha: 0.65),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
