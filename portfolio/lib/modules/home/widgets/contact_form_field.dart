import 'package:flutter/material.dart';
import 'package:my_portfolio_web_app/data/values/textstyles.dart';

class ContactFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final int maxLines;
  final TextEditingController textEditingController;

  ContactFormField({
    required this.textEditingController,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body2RegularWhite,
        ),
        SizedBox(height: 8),
        TextField(
          controller: textEditingController,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800],
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
