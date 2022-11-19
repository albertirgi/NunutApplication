import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class NunutButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final double widthBorder;
  final double widthButton;
  final double heightButton;
  final double borderRadius;
  final Function() onPressed;
  final EdgeInsets margin;
  const NunutButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.widthButton = double.infinity,
    this.heightButton = 55,
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.widthBorder = 1.0,
    this.borderRadius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthButton,
      height: heightButton,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        child: NunutText(title: title),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? nunutPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: Colors.black,
              width: widthBorder,
            ),
          ),
        ),
      ),
    );
  }
}
