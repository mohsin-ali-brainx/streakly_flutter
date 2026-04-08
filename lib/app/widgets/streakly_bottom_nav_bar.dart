import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';

class StreaklyBottomNavBar extends StatelessWidget {
  const StreaklyBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const double _iconBox = 24;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.bottomNavBarBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(
          top: BorderSide(color: Color(0x26D8C2BB)),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1485736D),
            blurRadius: 40,
            offset: Offset(0, -12),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 14, 8, 10),
          child: Row(
            children: [
              _Item(
                selected: selectedIndex == 0,
                label: 'TODAY',
                icon: (c) => _NavIcon(asset: 'assets/icons/nav_today.svg', color: c),
                onTap: () => onSelect(0),
              ),
              _Item(
                selected: selectedIndex == 1,
                label: 'HABITS',
                icon: (c) => _NavIcon(asset: 'assets/icons/nav_habits.svg', color: c),
                onTap: () => onSelect(1),
              ),
              _Item(
                selected: selectedIndex == 2,
                label: 'STATS',
                icon: (c) => _NavIcon(asset: 'assets/icons/nav_stats.svg', color: c),
                onTap: () => onSelect(2),
              ),
              _Item(
                selected: selectedIndex == 3,
                label: 'SETTINGS',
                icon: (c) => _NavIcon(asset: 'assets/icons/nav_settings.svg', color: c),
                onTap: () => onSelect(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.asset, required this.color});

  final String asset;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: 22,
      height: 22,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.selected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final Widget Function(Color color) icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c =
        selected ? AppColors.ctaBrown : AppColors.bottomNavInactive;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.habitsIconWellFill,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: StreaklyBottomNavBar._iconBox,
                  height: StreaklyBottomNavBar._iconBox,
                  child: Center(child: icon(c)),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    height: 1.2,
                    color: c,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
