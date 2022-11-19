import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class NunutTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  final double width;
  const NunutTextFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.obsecureText,
    required this.controller,
    this.width = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NunutText(
            title: title,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 2),
          TextFormField(
            cursorColor: Colors.black,
            obscureText: obsecureText,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: width,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.black, width: width),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
