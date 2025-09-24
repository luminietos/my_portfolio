import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_themes.dart';
import '../widgets/contact_form.dart'; // new widget

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Spacing.of(4).w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Me',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: Spacing.of(6).h),
            Text(
              'Interested in my work, or in working with me?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Send me a message below!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: Spacing.of(6).h),

            // 👇 Our form widget
            const ContactForm(),
          ],
        ),
      ),
    );
  }
}
