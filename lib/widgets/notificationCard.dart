import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class NotifCard extends StatelessWidget {
  final EdgeInsets? margin;
  final String title;
  final String desc;

  const NotifCard(
      {super.key, this.margin, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 1,
          )),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NunutText(title: title, size: 16, fontWeight: FontWeight.w500),
          SizedBox(height: 3),
          NunutText(title: desc, size: 14, fontWeight: FontWeight.w300),
        ],
      ),
    );
  }
}
