import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NunutText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextDecoration textDecoration;
  final TextOverflow? overflow;
  final bool isShadow;
  final double? height;

  const NunutText({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.size = 16,
    this.maxLines = 999,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
    this.overflow = TextOverflow.ellipsis,
    this.isShadow = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    List<Shadow> shadows = this.isShadow == true
        ? [
            Shadow(
              blurRadius: 0.0,
              color: Colors.black,
              offset: Offset(2.5, 2.5),
            ),
            Shadow(offset: Offset(-1.0, -1.0), color: Colors.black),
            Shadow(offset: Offset(1.0, -1.0), color: Colors.black),
            Shadow(offset: Offset(1.0, 1.0), color: Colors.black),
            Shadow(offset: Offset(-1.0, 1.0), color: Colors.black),
          ]
        : [];
    return Text(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          decoration: textDecoration,
          shadows: shadows,
          height: isShadow ? 1 : 1.5,
        ),
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
