import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class NunutCard extends StatelessWidget {
  final Widget? content;
  final EdgeInsets? margin;
  final EdgeInsets? paddingContent;
  final double? borderRadius;
  final double? height;
  const NunutCard({super.key, this.content, this.margin, this.paddingContent, this.borderRadius, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingContent ?? EdgeInsets.all(0),
      margin: margin ?? EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      height: height ?? 225,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(image: AssetImage("assets/nunutImage.png"), fit: BoxFit.cover)
      ),
      child: Stack(
        children: [
          content ?? SizedBox()
        ],
      ),
    );
  }
}