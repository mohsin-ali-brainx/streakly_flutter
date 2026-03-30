/// Prefix for assets served from this package (required by Flutter).
const String kStreaklyAssetsPackagePrefix = 'packages/streakly_assets';

/// Build a package asset path: `packages/streakly_assets/<relativePath>`.
String pathFor(String relativePath) {
  final trimmed = relativePath.trim();
  assert(
    !trimmed.startsWith('/'),
    'relativePath should not start with / (got: $relativePath)',
  );
  return '$kStreaklyAssetsPackagePrefix/$trimmed';
}

/// Icons under `assets/icons/`.
String iconPath(String fileName) => pathFor('assets/icons/$fileName');

/// Raster / vector images under `assets/images/`.
String imagePath(String fileName) => pathFor('assets/images/$fileName');
