import 'package:flutter/material.dart';

class ChatTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double width;
  const ChatTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.width = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ));
  }
}
