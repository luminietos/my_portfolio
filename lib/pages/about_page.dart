import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_themes.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi! I\'m Will.',
            style: Theme.of(context).textTheme.displayMedium,
          ),

          SizedBox(height: Spacing.of(6).h),

          Text(
            'I am a passionate software developer with a strong background in building cross-platform applications using technologies like Flutter. My journey in technology began with a curiosity for how things work and a desire to create seamless digital experiences.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          SizedBox(height: Spacing.of(4).h),

          Text(
            'Over the years, I have worked on a variety of projects ranging from mobile apps to web platforms. I enjoy collaborating with teams, learning new technologies, and solving challenging problems through clean and efficient solutions.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          SizedBox(height: Spacing.of(4).h),

          Text(
            'Outside of coding, I love exploring new places, reading about emerging tech trends, and contributing to open-source projects. I am always eager to take on new challenges and grow as a developer.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
