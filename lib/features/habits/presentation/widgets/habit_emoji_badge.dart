import 'package:flutter/material.dart';

/// Emoji “icon” for starter habits (matches onboarding template keys).
class HabitEmojiBadge extends StatelessWidget {
  const HabitEmojiBadge({super.key, required this.iconKey, this.size = 18});

  final String iconKey;
  final double size;

  static String emojiForKey(String key) {
    return switch (key) {
      'read' => '📖',
      'water' => '💧',
      'meditate' => '🧘',
      'walk' => '🚶',
      'journal' => '✍️',
      'custom' => '✨',
      _ => '✨',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Text(emojiForKey(iconKey), style: TextStyle(fontSize: size));
  }
}
