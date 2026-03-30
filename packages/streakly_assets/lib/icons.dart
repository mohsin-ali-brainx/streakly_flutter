import 'src/asset_paths.dart';

/// Pub name of this package (for [SvgPicture.asset] / [Image.asset] `package:`).
const String kStreaklyAssetsPackage = 'streakly_assets';

/// File names under `assets/icons/`.
abstract final class StreaklyIconNames {
  StreaklyIconNames._();

  static const String icWelcomeStars = 'ic_welcome_stars.svg';
}

abstract final class StreaklyIcons {
  StreaklyIcons._();

  /// Path for [SvgPicture.asset] / [Image.asset] when passing `package: kStreaklyAssetsPackage`.
  static String get icWelcomeStars => 'assets/icons/${StreaklyIconNames.icWelcomeStars}';

  /// Path for [Image.asset] without `package` (uses `packages/streakly_assets/...`).
  static String get icWelcomeStarsBundled =>
      iconPath(StreaklyIconNames.icWelcomeStars);
}
