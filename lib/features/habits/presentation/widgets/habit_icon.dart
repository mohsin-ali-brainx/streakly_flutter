import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';

class HabitIcon extends StatelessWidget {
  const HabitIcon({
    super.key,
    required this.iconKey,
    this.size = 24,
    this.color,
  });

  final String iconKey;
  final double size;
  final Color? color;

  static String assetForKey(String key) {
    return switch (key) {
      'read' => 'assets/icons/anchor_book.svg',
      'water' => 'assets/icons/anchor_leaf.svg',
      'meditate' => 'assets/icons/anchor_brain.svg',
      'walk' => 'assets/icons/anchor_runner.svg',
      'journal' => 'assets/icons/anchor_moon.svg',
      'custom' => 'assets/icons/anchor_more.svg',
      'sun' => 'assets/icons/anchor_sun.svg',
      'leaf' => 'assets/icons/anchor_leaf.svg',
      'dumbbell' => 'assets/icons/anchor_dumbbell.svg',
      'book' => 'assets/icons/anchor_book.svg',
      'moon' => 'assets/icons/anchor_moon.svg',
      'luna' => 'assets/icons/anchor_moon.svg',
      'runner' => 'assets/icons/anchor_runner.svg',
      'palette' => 'assets/icons/anchor_palette.svg',
      'brain' => 'assets/icons/anchor_brain.svg',
      'more' => 'assets/icons/anchor_more.svg',
      _ => 'assets/icons/anchor_more.svg',
    };
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetForKey(iconKey),
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? AppColors.visualAnchorIconBrown,
        BlendMode.srcIn,
      ),
    );
  }
}

