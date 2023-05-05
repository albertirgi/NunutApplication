import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_scroll/text_scroll.dart';

class NunutText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextDecoration textDecoration;
  final TextOverflow? overflow;
  final bool isTitle;
  final double height;
  final TextAlign? textAlign;

  const NunutText({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.size = 16,
    this.maxLines = 999,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
    this.overflow = TextOverflow.ellipsis,
    this.isTitle = false,
    this.height = 1.5,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    List<Shadow> shadows = this.isTitle == true
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
          color: isTitle ? Colors.white : color,
          fontSize: size,
          fontWeight: isTitle ? FontWeight.bold : fontWeight,
          decoration: textDecoration,
          shadows: shadows,
          height: isTitle ? 1 : height,
        ),
      ),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

class NunutScrollText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextDecoration textDecoration;
  final bool isTitle;
  final double height;
  final TextAlign? textAlign;

  const NunutScrollText({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.size = 16,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
    this.isTitle = false,
    this.height = 1.5,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    List<Shadow> shadows = this.isTitle == true
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
    return TextScroll(
      title,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: isTitle ? Colors.white : color,
          fontSize: size,
          fontWeight: isTitle ? FontWeight.bold : fontWeight,
          decoration: textDecoration,
          shadows: shadows,
          height: isTitle ? 1 : height,
        ),
      ),
      textAlign: textAlign,
      velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
    );
  }
}
