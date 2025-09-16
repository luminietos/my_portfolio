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
      final uri = Uri.parse(
        'https://formspree.io/f/xnnbrdjb',
      ); // Fromspree endpoint
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text,
          'email': _emailController.text,
          'message': _messageController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() => _isSuccess = true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send. Try again!')),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: onSurface, size: 48.w),
            SizedBox(height: Spacing.of(4).h),
            Text(
              "Thanks! I'll get back to you soon 💌",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: onSurface),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: Spacing.of(8).h),
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
            decoration: buildDecoration("Your message", Icons.message).copyWith(
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

          // Send button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isSending ? null : _sendForm,
              icon: _isSending
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(onSurface),
                      ),
                    )
                  : Icon(Icons.send, color: surface),
              label: Text(
                _isSending ? 'Sending...' : 'Send',
                style: TextStyle(color: surface),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: onSurface,
                padding: EdgeInsets.symmetric(vertical: Spacing.of(4).h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
