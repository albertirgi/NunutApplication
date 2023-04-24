import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nunut_application/widgets/nunutText.dart';

import '../screens/topUp.dart';

class NunutTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  final double width;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final bool is_currency;
  final bool enabled;

  const NunutTextFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.obsecureText,
    required this.controller,
    this.width = 1.0,
    this.keyboardType = TextInputType.text,
    this.suffixIcon = const SizedBox(),
    this.is_currency = false,
    this.enabled = true,
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
            inputFormatters: is_currency
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    //fazer o formater para dinheiro
                    CurrencyInputFormatter()
                  ]
                : null,
            cursorColor: Colors.black,
            obscureText: obsecureText,
            controller: controller,
            keyboardType: keyboardType,
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
              suffixIcon: suffixIcon,
              enabled: enabled,
            ),
          ),
        ],
      ),
    );
  }
}
