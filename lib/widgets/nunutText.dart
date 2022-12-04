import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NunutText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextDecoration textDecoration;

  const NunutText({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.size = 16,
    this.maxLines = 999,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          decoration: textDecoration,
        ),
      ),
      maxLines: maxLines,
    );
  }
}
