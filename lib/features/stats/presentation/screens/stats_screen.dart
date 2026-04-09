import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../habits/presentation/widgets/today_dashboard_header.dart';
import '../controller/stats_controller.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final c = StatsController();
        c.start();
        return c;
      },
      child: const _StatsScaffold(),
    );
  }
}

class _StatsScaffold extends StatelessWidget {
  const _StatsScaffold();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Consumer<StatsController>(
      builder: (context, c, _) {
        return Scaffold(
          backgroundColor: cs.surface,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.pagePaddingHLoose,
                    4,
                    AppDimens.pagePaddingHLoose,
                    0,
                  ),
                  sliver: const SliverToBoxAdapter(
                    child: TodayDashboardHeader(),
                  ),
                ),
                if (c.loading && c.summary == null)
                  const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.habitsPrimaryCta,
                      ),
                    ),
                  )
                else if (c.error != null && c.summary == null)
                  SliverFillRemaining(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              c.error!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                color: AppColors.habitsMuted,
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: () => c.refresh(),
                              child: Text(StatsStrings.retry),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else if (c.summary != null)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.pagePaddingHLoose,
                      8,
                      AppDimens.pagePaddingHLoose,
                      110,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Text(
                          StatsStrings.eyebrow,
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            color: AppColors.habitsMuted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          StatsStrings.title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                            letterSpacing: -0.8,
                            color: AppColors.habitsTitleInk,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          StatsStrings.subtitle,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.45,
                            color: AppColors.habitsBodyBrown,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _TotalCheckInsCard(value: c.summary!.totalCheckIns),
                        const SizedBox(height: 14),
                        _LongestStreakCard(days: c.summary!.longestStreakDays),
                        const SizedBox(height: 14),
                        _StreaksPreservedCard(
                          value: c.summary!.streaksPreserved,
                        ),
                        const SizedBox(height: 20),
                        _WeeklyOverviewCard(
                          weekStart: c.summary!.weekStartMonday,
                          weekEnd: c.summary!.weekEndSunday,
                          dayTotals: c.summary!.weekDayTotals,
                        ),
                        const SizedBox(height: 16),
                        _HabitDiversityCard(rows: c.summary!.diversityRows),
                        const SizedBox(height: 16),
                        _ConsistencyScoreCard(
                          percent: c.summary!.consistencyPercent,
                        ),
                      ]),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TotalCheckInsCard extends StatelessWidget {
  const _TotalCheckInsCard({required this.value});

  final int value;

  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1485736D),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 26,
                color: AppColors.habitsPrimaryCta,
              ),
              const SizedBox(width: 10),
              Text(
                StatsStrings.totalCheckIns,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.9,
                  color: AppColors.habitsMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$value',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 44,
              fontWeight: FontWeight.w800,
              height: 1,
              letterSpacing: -1.0,
              color: AppColors.habitsTitleInk,
            ),
          ),
        ],
      ),
    );
  }
}

class _LongestStreakCard extends StatelessWidget {
  const _LongestStreakCard({required this.days});

  final int days;

  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.statsLongestStreakBg,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: const Color(0x33000000),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.local_fire_department_rounded,
            color: Color(0xFFFFB74D),
            size: 26,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StatsStrings.longestStreak,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.9,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$days ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 44,
                          fontWeight: FontWeight.w800,
                          height: 1,
                          letterSpacing: -1.0,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: StatsStrings.longestStreakDaysSuffix,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StreaksPreservedCard extends StatelessWidget {
  const _StreaksPreservedCard({required this.value});

  final int value;

  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.statsDiversityCardBg,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shield_rounded,
                      size: 24,
                      color: AppColors.todayTealDone,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      StatsStrings.streaksPreserved,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.9,
                        color: AppColors.habitsMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '$value',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    letterSpacing: -1.0,
                    color: AppColors.habitsTitleInk,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyOverviewCard extends StatelessWidget {
  const _WeeklyOverviewCard({
    required this.weekStart,
    required this.weekEnd,
    required this.dayTotals,
  });

  final DateTime weekStart;
  final DateTime weekEnd;
  final List<int> dayTotals;

  static final _df = DateFormat('EEE, MMM d');
  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    final range =
        '${_df.format(weekStart)} – ${_df.format(weekEnd)}';
    const labels = [
      StatsStrings.mon,
      StatsStrings.tue,
      StatsStrings.wed,
      StatsStrings.thu,
      StatsStrings.fri,
      StatsStrings.sat,
      StatsStrings.sun,
    ];
    final maxH = 140.0;
    final maxV = dayTotals.isEmpty
        ? 1
        : dayTotals.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1485736D),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.eco_rounded,
                  size: 32,
                  color: AppColors.ctaBrown,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StatsStrings.weeklyOverview,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.habitsTitleInk,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      range,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.habitsMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.statsWeeklyLegendMuted,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC4A896),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: maxH,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (i) {
                  final v = (i < dayTotals.length) ? dayTotals[i] : 0;
                  final rawH = maxV <= 0 ? 0.0 : (v / maxV) * 64.0;
                  final h = v == 0 ? 0.0 : rawH.clamp(10.0, 64.0);
                  final barColor = i.isEven
                      ? AppColors.statsWeeklyLegendMuted
                      : const Color(0xFFC4A896);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        height: h,
                        decoration: BoxDecoration(
                          color: barColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(7, (i) {
              return Expanded(
                child: Text(
                  labels[i],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: AppColors.habitsMuted,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _HabitDiversityCard extends StatelessWidget {
  const _HabitDiversityCard({required this.rows});

  final List<StatsDiversityRow> rows;

  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
      decoration: BoxDecoration(
        color: AppColors.statsDiversityCardBg,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StatsStrings.habitDiversity,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.habitsTitleInk,
            ),
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 46,
                  decoration: BoxDecoration(
                    color: rows[i].accentColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rows[i].title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.habitsTitleInk,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${rows[i].monthCompletions} ${StatsStrings.completionsThisMonth}',
                        style: GoogleFonts.manrope(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.habitsMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ConsistencyScoreCard extends StatelessWidget {
  const _ConsistencyScoreCard({required this.percent});

  final int percent;

  static const _radius = 20.0;

  String _body() {
    if (percent >= 85) return StatsStrings.consistencyHighBody(percent);
    if (percent >= 50) return StatsStrings.consistencyMidBody(percent);
    return StatsStrings.consistencyLowBody(percent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
      decoration: BoxDecoration(
        color: AppColors.statsConsistencyBg,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.statsConsistencyBg.withValues(alpha: 0.35),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StatsStrings.consistencyTitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$percent%',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 44,
              fontWeight: FontWeight.w800,
              height: 1,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _body(),
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.4,
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }
}
