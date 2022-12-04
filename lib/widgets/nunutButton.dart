import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class NunutButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final Icon? iconButton;
  final double textSize;
  final double widthBorder;
  final double widthButton;
  final double heightButton;
  final double borderRadius;
  final double elevation;
  final Function() onPressed;
  final EdgeInsets margin;
  final FontWeight fontWeight;

  const NunutButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.widthButton = double.infinity,
    this.heightButton = 55,
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.textColor = Colors.black,
    this.iconButton,
    this.textSize = 16.0,
    this.widthBorder = 1.0,
    this.borderRadius = 24.0,
    this.borderColor = Colors.black,
    this.elevation = 0.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthButton,
      height: heightButton,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NunutText(
              title: title,
              color: textColor,
              size: textSize,
              fontWeight: fontWeight,
            ),
            if (iconButton != null) SizedBox(width: 8),
            if (iconButton != null) iconButton as Widget
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? nunutPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor!,
              width: widthBorder,
            ),
          ),
          elevation: elevation,
        ),
      ),
    );
  }
}
