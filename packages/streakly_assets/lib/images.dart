// import 'src/asset_paths.dart'; // when adding images: use imagePath(fileName)

/// File names for assets in `assets/images/` (no directory / package prefix).
abstract final class StreaklyImageNames {
  StreaklyImageNames._();

  // Example:
  // static const String logo = 'logo.png';
}

/// Fully-qualified asset paths for raster / vector images.
abstract final class StreaklyImages {
  StreaklyImages._();

  // Example:
  // static String get logo => imagePath(StreaklyImageNames.logo);
}
