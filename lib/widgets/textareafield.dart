import 'package:flutter/material.dart';

class TextAreaField extends StatefulWidget {
  const TextAreaField({super.key, required this.controller, required this.label, this.initialValue});

  final TextEditingController controller;
  final String label;
  final String? initialValue;

  @override
  State<TextAreaField> createState() => _TextAreaFieldState();
}

class _TextAreaFieldState extends State<TextAreaField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 4,
      maxLines: 10,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Contenu',
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
