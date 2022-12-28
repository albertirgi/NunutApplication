import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';

class NunutBackground extends StatelessWidget {
  List<Widget>? listWidgetColumn;
  List<Widget>? listWidgetChild;
  Widget? child;
  EdgeInsets? padding;
  EdgeInsets? margin;
  double? width;
  double? height;

  NunutBackground({
    super.key,
    this.listWidgetColumn,
    this.listWidgetChild,
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: nunutPrimaryColor,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (listWidgetColumn != null) ...listWidgetColumn!,
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                width: width,
                height: height,
                padding: this.padding != null ? this.padding : EdgeInsets.all(8),
                margin: this.margin != null ? this.margin : EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: child != null ? child : Container(),
              ),
            ),
          ],
        ),
        if (listWidgetChild != null) ...listWidgetChild!
      ],
    );
  }
}
