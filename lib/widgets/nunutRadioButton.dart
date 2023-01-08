import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class NunutRadioButton extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final String? groupValue;
  final String value;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final ValueChanged<String> onChanged;

  const NunutRadioButton({
    super.key,
    required this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    required this.groupValue,
    required this.value,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      groupValue: groupValue,
      value: value,
      onChanged: (String? newValue) {
        onChanged(newValue!);
      },
      title: NunutText(
        title: label,
        size: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      activeColor: nunutPrimaryColor,
    );
  }
}
