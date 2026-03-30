/// User-visible copy. Replace with ARB / intl when you add locales.
abstract final class AppStrings {
  AppStrings._();

  static const appName = 'Streakly';
  static const progress = 'PROGRESS';
  static const cancel = 'Cancel';
  static const add = 'Add';
  static const notNow = 'Not now';
  static const nextArrow = 'Next →';
  static const commonSoon = 'Soon';
}

abstract final class WelcomeStrings {
  WelcomeStrings._();

  static const philosophyEyebrow = 'THE PHILOSOPHY';
  static const philosophyLead = 'Honor the ';
  static const philosophyEmphasis = 'daily ritual';
  static const philosophyTrail = ' — consistency beats intensity.';
  static const headline1 = 'Build tiny habits.';
  static const headline2 = 'Keep streaks.';
  static const headline3 = 'Recover when life happens.';
  static const body =
      'We believe in the power of small wins. Turn your aspirations into '
      'effortless routines with a mindful approach to consistency.';
  static const getStarted = 'Get Started';
  static const socialProof = 'JOIN 50,000+ MINDFUL STREAK-KEEPERS';
}

abstract final class SetupStrings {
  SetupStrings._();

  static const eyebrow = 'CURATION';
  static const title = 'Choose 3–5 starter habits';
  static const subtitle =
      'Small steps lead to meaningful change. Select the rituals that '
      'resonate with your lifestyle.';
  static const customHabit = 'Custom Habit';
  static const quote =
      '“The secret of your future is hidden in your daily routine.”';
  static const finishSetup = 'Finish Setup →';
  static const next = 'Next';
  static const footerHint = 'You can always change these later in settings.';

  static const dialogTitle = 'Custom habit';
  static const habitNameLabel = 'Habit name';
  static const habitNameHint = 'e.g. Stretch, Learn Spanish';
  static const categoryLabel = 'Category or note (optional)';
  static const categoryHint = 'e.g. Wellness, 15 minutes daily';
}

abstract final class NotificationsStrings {
  NotificationsStrings._();

  /// Figma “Notifications Permission” — [Login-Page--Community](https://www.figma.com/design/i1gV0yG1KlO7vl982pCVq1/Login-Page--Community-?node-id=191-206)
  static const headlineLine1 = 'Stay consistent.';
  static const headlineLine2 = 'Reminders that care.';
  static const subtitleLine1 = 'We’ll remind you when it’s time to';
  static const subtitleLine2 = 'check in, so your progress never';
  static const subtitleLine3 = 'skips a beat.';
  static const mindsetLabel = 'MINDSET';
  static const mindsetBody = 'Gentle nudges, no pressure.';
  static const reliabilityLabel = 'RELIABILITY';
  static const reliabilityBody = 'Keep your streaks protected.';
  static const enable = 'Enable Notifications';
  static const later = 'Later';
  static const footerMark = 'STREAKLY';
}

abstract final class InsuranceStrings {
  InsuranceStrings._();

  static const eyebrow = 'STREAK PROTECTION';
  static const titleLine1 = 'Missed a day?';
  static const titleLine2 = 'Save your streak.';
  static const primaryCta = 'Finish Setup';
  static const subtitle =
      'Everyone slips. Streak Insurance helps you recover without losing '
      'motivation — because consistency is returning, not perfection.';
  static const bullet1Title = '2 recoveries per month';
  static const bullet1Subtitle =
      'Use a token to cover yesterday when life gets in the way.';
  static const bullet2Title = 'Yesterday only';
  static const bullet2Subtitle =
      'Insurance applies to the day you missed — fair and simple.';
  static const bullet3Title = 'Stay in the game';
  static const bullet3Subtitle =
      'Skip the “I broke my streak, I quit” spiral and keep building.';
  static const footerHint = 'You can review this anytime in Settings.';
}

abstract final class TodayStrings {
  TodayStrings._();

  static const title = 'Today';
  static const placeholder =
      'Next: habits list + 1-tap check-ins + missed-day insurance banner.';
  static const insuranceCard =
      'You missed yesterday. Save your streak with Insurance.';
  static const useInsurance = 'Use';
}

abstract final class HabitsStrings {
  HabitsStrings._();

  static const title = 'Habits';
  static const placeholder =
      'Next: create/edit habit (name, icon, reminder) and list of habits.';
  static const addHabit = 'Add micro habit';
}

abstract final class StatsStrings {
  StatsStrings._();

  static const title = 'Stats';
  static const placeholder = 'Next: weekly completion + streak highlights.';
}

abstract final class SettingsStrings {
  SettingsStrings._();

  static const title = 'Settings';
  static const notificationsTitle = 'Notifications';
  static const notificationsSubtitle = 'Gentle reminders for micro habits';
  static const themeTitle = 'Theme';
  static const themeSubtitle = 'Light & Dark';
  static const insuranceTitle = 'Streak Insurance';
  static const insuranceSubtitle = '2 tokens/month • covers yesterday only';
  static const system = 'System';
  static const tokensPlaceholder = '2/2';
}
