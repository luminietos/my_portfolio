import 'package:flutter/material.dart';
import '../../theme/app_themes.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Placeholder div at the top of footer (empty)
        Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            '© 2025 Wilma Paloheimo. All rights reserved.',
            style: TextStyle(
              color: colors.primary.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
