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

  static const deniedTitle = 'Notifications are off';
  static const deniedBody =
      'To get reminders, enable notifications in your system settings. '
      'You can continue without them and turn this on later.';
  static const openSettings = 'Open Settings';
  static const continueAnyway = 'Continue';
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
  static const greetingName = 'Sam';
  static const toggleDoneTooltip = 'Mark done for today';
  static const emptyTitle = 'No habits yet';
  static const emptyBody =
      'Finish onboarding to add starter habits, or open Habits to add more.';
  static const useInsurance = 'Use Insurance';
  static const tokensThisMonth = 'tokens left this month';
  static const sectionHabits = "Today's habits";
  static const manageLink = 'Manage';
  static const insightTitle = 'Consistency';
  static const insightBody =
      'Small daily check-ins add up. Keep the momentum going today.';
  static const editHabit = 'Edit habit';
  static const recoveryTitle = 'Streak Insurance Recovery';
  static const recoveryPerspective = 'Perspective';
  static const recoveryHeadline =
      'It happens. Consistency isn\'t perfect, it\'s returning.';
  static String recoveryMissedYesterday(String habitName) =>
      'You missed your \'$habitName\' yesterday.';
  static const recoveryAtRisk = 'DAY STREAK AT RISK';
  static const recoveryTokens = 'Insurance Tokens';
  static const recoveryTokensAvailable = 'available to use';
  static const recoveryUseOne = 'Use 1 Insurance';
  static const recoveryReset = 'Reset Streak';
  static const recoveryYesterdayOnly = 'Insurance can only cover yesterday.';
  static const recoveryFailed = 'Could not apply insurance. Try again.';

  static String greetingTimePrefix() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  static String completedLine(int done, int total) => 'Completed $done/$total';

  static String progressEncouragement(int done, int total) {
    if (total <= 0) return 'Add habits to start tracking.';
    if (done == total) return 'All habits complete. Nice work!';
    if (done == 0) return 'Start with one small win.';
    final left = total - done;
    if (left == 1) return 'Almost there! One more to go.';
    return '$left to go — you’ve got this.';
  }

  static String insuranceSaveStreak(int days) {
    if (days <= 0) {
      return 'You missed\nyesterday.\nSave your streak?';
    }
    return 'You missed\nyesterday.\nSave your $days-day streak?';
  }

  static String streakCaps(int days) {
    if (days <= 0) return 'START YOUR STREAK';
    if (days == 1) return '1-DAY STREAK 🔥';
    return '$days-DAY STREAK 🔥';
  }
}

abstract final class HabitsStrings {
  HabitsStrings._();

  static const title = 'Habits';
  static const subtitle =
      'Reorder anytime. Tap a card to edit name, icon, or reminders.';
  static const reorderHint = 'Drag ⋮⋮ on the left to reorder.';
  static const empty = 'No habits yet — finish setup or add one below.';
  static const addHabit = 'Add habit';
  static const reminderOn = 'Reminder on';
  static const reminderOff = 'No reminder';
  static const addTitle = 'New habit';
  static const editTitle = 'Edit habit';
  static const nameHint = 'e.g. Morning walk, Read 10 pages';
  static const iconLabel = 'Icon';
  static const sectionHabitName = 'Habit name';
  static const sectionIcon = 'Choose icon';
  static const sectionReminder = 'Reminder';
  static const dailyAt = 'Daily at';
  static const scheduleNoReminder = 'No reminder set';
  static const reminderSwitch = 'Daily reminder';
  static const pickTime = 'Change time';
  static const save = 'Save habit';
  static const archiveHabit = 'Archive habit';
  static const archiveTitle = 'Archive this habit?';
  static const archiveBody =
      'It will disappear from Today and Habits. Your past check-ins stay in history.';
  static const archiveConfirm = 'Archive';
  static const newHabitPageTitle = 'New Habit';
  static const habitDetailTitle = 'Habit Detail';
  static const habitIdentity = 'Habit identity';
  static const quickTemplates = 'Quick templates';
  static const visualAnchor = 'Visual anchor';
  static const quote =
      '“The secret of your future is hidden in your daily routine.”';
  static const saveHabitArrow = 'Save Habit →';
  static const templatesDrinkWater = 'Drink water';
  static const templatesNoCoffee = 'No coffee';
  static const templatesFlour = 'Flour';
  static const templatesYoga = 'Yoga';
  static const currentStreak = 'Current streak';
  static const bestStreak = 'Best streak';
  static const personalBest = 'Personal Best';
  static const activity = 'Activity';
  static const done = 'Done';
  static const missed = 'Missed';
  static const streakInsurance = 'Streak Insurance';
  static const insuranceBody =
      'Don\'t lose your progress if you miss a day. Shields reset monthly.';
  static const usedThisMonth = 'Used this month';
  static const editHabit = 'Edit Habit';
}

abstract final class StatsStrings {
  StatsStrings._();

  static const eyebrow = 'PERFORMANCE INSIGHT';
  static const title = 'Stats';
  static const subtitle =
      'Your consistency is your superpower. Here is how your rituals '
      'shaped your week.';
  static const totalCheckIns = 'TOTAL CHECK-INS';
  static const longestStreak = 'LONGEST STREAK';
  static const longestStreakDaysSuffix = 'days';
  static const streaksPreserved = 'STREAKS PRESERVED';
  static const weeklyOverview = 'Weekly Overview';
  static const habitDiversity = 'Habit Diversity';
  static const completionsThisMonth = 'completions this month';
  static const consistencyTitle = 'Consistency Score';
  static String consistencyHighBody(int percent) =>
      'You\'re in the top 5% of users this week. Keep the momentum going!';
  static String consistencyMidBody(int percent) =>
      'Solid week — small wins are stacking up.';
  static String consistencyLowBody(int percent) =>
      'Every check-in counts. Build one ritual at a time.';
  static const mon = 'MON';
  static const tue = 'TUE';
  static const wed = 'WED';
  static const thu = 'THU';
  static const fri = 'FRI';
  static const sat = 'SAT';
  static const sun = 'SUN';
  static const loadFailed = 'Could not load stats.';
  static const retry = 'Try again';
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
