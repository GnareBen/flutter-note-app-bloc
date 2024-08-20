import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? initialValue;

  const MyTextFormField({super.key, required this.controller, required this.label, this.initialValue});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 25,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
      ),
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}