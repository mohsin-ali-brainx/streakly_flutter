/// Shared visual assets (icons, images, fonts) for Streakly.
///
/// For [SvgPicture.asset] / [Image.asset] with `package:`, use [StreaklyIcons]
/// paths with [kStreaklyAssetsPackage]. For [rootBundle.load] use
/// [StreaklyIcons.icWelcomeStarsBundled] style paths from [iconPath].
///
/// Import this library for path helpers and typed asset constants:
/// - [StreaklyIcons], [StreaklyIconNames], [kStreaklyAssetsPackage]
/// - [StreaklyImages], [StreaklyImageNames]
/// - [StreaklyFonts]
library streakly_assets;

export 'src/asset_paths.dart';
export 'icons.dart';
export 'images.dart';
export 'fonts.dart';
