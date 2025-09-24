import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../theme/app_themes.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSending = false;
  bool _isSuccess = false;

  Future<void> _sendForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      final uri = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': 'service_u0izxn9', // 👈 your Service ID
          'template_id': 'template_f5rg7ff', // 👈 your Template ID
          'user_id': 'tpl1TQ_-DBbkAnrYE', // 👈 your Public Key
          'template_params': {
            'name': _nameController.text,
            'email': _emailController.text,
            'message': _messageController.text,
            'time': DateTime.now().toString(),
          },
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // ✅ Clear fields
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        setState(() => _isSuccess = true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isSending = false);
    }
  }

  InputDecoration buildDecoration(String label, IconData icon) {
    final colors = Theme.of(context).colorScheme;
    final surface = colors.surface;
    final onSurface = colors.onSurface;

    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: onSurface),
      prefixIcon: Icon(icon, color: onSurface),
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: onSurface),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: onSurface.withOpacity(0.6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: onSurface, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: Spacing.of(2).h,
        horizontal: Spacing.of(4).w,
      ),
      prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final surface = colors.surface;
    final onSurface = colors.onSurface;

    if (_isSuccess) {
      return Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(milliseconds: 800),
          curve: Curves.easeOutBack, // nice lil bounce effect ^^
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(scale: value, child: child),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Image
              Image.asset(
                'assets/images/handphone_invisibg.png',
                width: 120.w,
                height: 120.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: Spacing.of(4).h),
              Text(
                "Thanks! I'll get back to you soon 💌",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: Spacing.of(8).h),
      child: Form(
        // 👈 FIX: Wrap everything inside Form
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name
            TextFormField(
              controller: _nameController,
              style: TextStyle(color: onSurface),
              decoration: buildDecoration("Your Name", Icons.person).copyWith(
                labelStyle: WidgetStateTextStyle.resolveWith((states) {
                  if (states.contains(WidgetState.focused)) {
                    return TextStyle(color: Colors.grey); // Focused: grey
                  }
                  return TextStyle(color: onSurface); // Default: onSurface
                }),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: onSurface, width: 2),
                ),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter your name'
                  : null,
            ),
            SizedBox(height: Spacing.of(4).h),

            // Email
            TextFormField(
              controller: _emailController,
              style: TextStyle(color: onSurface),
              decoration: buildDecoration("Your Email", Icons.email).copyWith(
                labelStyle: WidgetStateTextStyle.resolveWith((states) {
                  if (states.contains(WidgetState.focused)) {
                    return TextStyle(color: Colors.grey); // Focused: grey
                  }
                  return TextStyle(color: onSurface); // Default: onSurface
                }),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: onSurface, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter your email';
                if (!value.contains('@')) return 'Enter a valid email';
                return null;
              },
            ),
            SizedBox(height: Spacing.of(4).h),

            // Message
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              style: TextStyle(color: onSurface),
              textAlignVertical: TextAlignVertical.top,
              decoration: buildDecoration("Your message", Icons.message)
                  .copyWith(
                    alignLabelWithHint: true,
                    labelStyle: WidgetStateTextStyle.resolveWith((states) {
                      if (states.contains(WidgetState.focused)) {
                        return TextStyle(color: Colors.grey); // Focused: grey
                      }
                      return TextStyle(color: onSurface); // Default: onSurface
                    }),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 12.w,
                    ),
                  ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter a message'
                  : null,
            ),
            SizedBox(height: Spacing.of(6).h),

            // SEND BUTTON (Fixed Overflow)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: onSurface,
                  padding: EdgeInsets.symmetric(vertical: Spacing.of(4).h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isSending
                          ? SizedBox(
                              width: 16.w,
                              height: 16.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(onSurface),
                              ),
                            )
                          : Icon(Icons.send, color: surface),
                      SizedBox(width: 8.w),
                      Text(
                        _isSending ? 'Sending...' : 'Send',
                        style: TextStyle(color: surface),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
