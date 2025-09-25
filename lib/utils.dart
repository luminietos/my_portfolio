// TODO Implement this library.

import 'package:flutter/foundation.dart';

/// Returns the correct asset path depending on web or other platforms.
/// On web, images are referenced via the nested assets folder.
String assetPath(String relativePath) {
  if (kIsWeb) {
    // GitHub Pages / Flutter Web build
    return 'assets/$relativePath';
  } else {
    // Local/mobile/desktop
    return 'assets/$relativePath';
  }
}
