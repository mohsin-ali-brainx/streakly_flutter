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
    this.labelStyle,
    this.height,
    this.padding,
  });

  final String label;
  final Future<void> Function()? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final OutlinedBorder? shape;
  final TextStyle? labelStyle;

  /// When null, uses [AppDimens.primaryButtonHeight].
  final double? height;

  /// When null, uses theme defaults. Onboarding Figma uses 24×16 horizontal×vertical.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final buttonHeight = height ?? AppDimens.primaryButtonHeight;

    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? cs.primary,
          foregroundColor: foregroundColor ?? cs.onPrimary,
          shape: shape,
          textStyle: labelStyle,
          padding: padding,
          minimumSize: Size(double.infinity, buttonHeight),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
