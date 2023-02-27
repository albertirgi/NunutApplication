import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class PopUpLoading extends StatelessWidget {
  final String title;
  final String subtitle;
  final double height;
  final double width;

  const PopUpLoading({
    super.key,
    required this.title,
    required this.subtitle,
    this.height = 200,
    this.width = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: nunutPrimaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(38),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CircularProgressIndicator(
                  value: null,
                  strokeWidth: 3.0,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NunutText(title: title, size: 20, fontWeight: FontWeight.bold),
                    NunutText(title: subtitle, size: 14, fontWeight: FontWeight.w500),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
