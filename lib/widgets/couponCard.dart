import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class CouponCard extends StatelessWidget {
  final EdgeInsets? margin;
  final String imagePath;
  final Widget date;
  final Widget minTransaction;
  final bool useBorder;
  final String title;
  final bool isList;

  const CouponCard({
    super.key,
    this.margin,
    required this.imagePath,
    required this.date,
    required this.minTransaction,
    this.useBorder = true,
    required this.title,
    this.isList = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: useBorder
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            )
          : null,
      elevation: 0.0,
      color: useBorder ? Colors.white : Colors.transparent,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: 125,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(imagePath, fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: isList ? 14 : 20),
            child: Column(
              children: [
                NunutText(title: title, size: 18, maxLines: 2, fontWeight: FontWeight.bold, height: 1.2),
                isList ? SizedBox(height: 12) : SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: NunutText(title: "Berlaku Hingga :", size: 14),
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 14),
                            SizedBox(width: 3),
                            date,
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: NunutText(title: "Minimal Transaksi :", size: 14),
                        ),
                        Row(
                          children: [
                            Icon(Icons.attach_money, size: 14),
                            SizedBox(width: 3),
                            minTransaction,
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
