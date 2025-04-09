import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.onChanged,
  });
  final String hintText;
  final String labelText;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'this field is required';
        }
      },
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.white),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 20,
          borderSide: BorderSide(color: Colors.white60),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          gapPadding: 20,
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
