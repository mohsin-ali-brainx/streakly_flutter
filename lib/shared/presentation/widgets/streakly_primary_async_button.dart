import 'package:flutter/material.dart';

import '../../../core/constants/app_dimens.dart';

/// Full-width primary button with optional loading state (onboarding CTAs).
class StreaklyPrimaryAsyncButton extends StatelessWidget {
  const StreaklyPrimaryAsyncButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
  });

  final String label;
  final Future<void> Function()? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: AppDimens.primaryButtonHeight,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? cs.primary,
          foregroundColor: foregroundColor ?? cs.onPrimary,
          shape: shape,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: AppDimens.smallProgressSize,
                height: AppDimens.smallProgressSize,
                child: CircularProgressIndicator(
                  strokeWidth: AppDimens.smallProgressStroke,
                  color: foregroundColor ?? cs.onPrimary,
                ),
              )
            : Text(label),
      ),
    );
  }
}
