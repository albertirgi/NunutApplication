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
  final int type;
  final Function()? onPressedArrowButton;

  const NunutButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.onPressedArrowButton,
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
    this.type = 1,
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
          mainAxisAlignment:
              type != 1 ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            NunutText(
              title: title,
              color: textColor,
              size: textSize,
              fontWeight: fontWeight,
            ),
            //if (iconButton != null) SizedBox(width: 8),
            if (iconButton != null) Spacer(),
            if (iconButton != null) iconButton as Widget,
            if (type == 2 || type == 3) Spacer(),
            if (type == 2)
              InkWell(
                onTap: onPressedArrowButton,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            if (type == 3)
              InkWell(
                onTap: onPressedArrowButton,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 16,
                ),
              )
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
