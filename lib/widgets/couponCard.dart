import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class CouponCard extends StatelessWidget {
  final EdgeInsets? margin;
  final String imagePath;
  final Widget date;
  final Widget minTransaction;

  const CouponCard({
    super.key,
    this.margin,
    required this.imagePath,
    required this.date,
    required this.minTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 125,
            child: Image.network(imagePath, fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
