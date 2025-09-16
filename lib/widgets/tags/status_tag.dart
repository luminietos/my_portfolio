// status_tag.dart
import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/tags/tag_widget.dart';

enum ProjectStatus { ongoing, finished }

class StatusTag extends StatelessWidget {
  final ProjectStatus status;

  const StatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ProjectStatus.ongoing:
        return TagWidget(
          text: "• Ongoing",
          backgroundColor: Colors.transparent, // Light yellow
          textColor: const Color(0xFFFBC02D), // Dark yellow
          fontSize: 12,
          horizontalPadding: 8,
          verticalPadding: 4,
        );
      case ProjectStatus.finished:
        return TagWidget(
          text: "• Finished",
          backgroundColor: Colors.transparent, // Light green
          textColor: const Color.fromARGB(255, 106, 192, 111), // Dark green
          fontSize: 12,
          horizontalPadding: 8,
          verticalPadding: 4,
        );
    }
  }
}
