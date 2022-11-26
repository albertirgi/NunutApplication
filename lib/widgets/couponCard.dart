import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.black,
          width: 2.0
        )
      ),
      child: Column(
        children: [
          Image.asset("assets/nunutImage.png", fit: BoxFit.cover),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NunutText(title: "Berlaku Hingga :"),
                    Spacer(),
                    NunutText(title: "Minimal Transaksi :")
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.timeline),
                    NunutText(title: "28 Januari 2021"),
                    Spacer(),
                    Icon(Icons.money),
                    NunutText(title: "Rp. 15.000")
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