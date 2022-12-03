import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/couponCard.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';

import '../theme.dart';

class PromotionList extends StatelessWidget {
  const PromotionList({super.key});

  Widget promoTerbaru(String heading, int nominalDiskon, String kodePromo) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 8,
        left: 8,
        right: 24,
        top: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: nunutPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NunutText(title: heading, size: 14),
          NunutText(title: "Rp. ${nominalDiskon}", size: 14),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.discount_outlined),
              NunutText(
                title: "Kode Promo : ${kodePromo}",
                size: 14,
                fontWeight: FontWeight.bold,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          BorderedText(
            child: Text(
              "Promo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            strokeWidth: 3.0,
            strokeColor: Colors.black,
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 0,
            ),
            child: NunutText(
              title: "Kode Promo",
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: TextField(
                    decoration: new InputDecoration(
                      hintText: "Kode Promo",
                      labelStyle: new TextStyle(
                        color: const Color(0xFF424242),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                NunutButton(
                  title: "Gunakan",
                  onPressed: () {},
                  widthButton: 115,
                  heightButton: 40,
                  borderRadius: 0,
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 0,
            ),
            child: NunutText(title: "Promo Terbaru"),
          ),
          SizedBox(height: 24),
          Container(
            height: 95,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return promoTerbaru("Lebih Hemat Diskon", 5000, "NUNUT1");
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 8);
              },
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 0,
            ),
            child: NunutText(title: "Kuponku"),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            itemBuilder: (context, index) {
              return CouponCard(
                imagePath:
                    "https://t3.ftcdn.net/jpg/03/54/26/10/360_F_354261018_RD5YEbufu7Yjck3SNiRC6yfJLZoxIegZ.jpg",
                date: NunutText(
                  title: "28 Januari 2022",
                  fontWeight: FontWeight.bold,
                ),
                minTransaction: NunutText(
                  title: "Rp. 15.000",
                  fontWeight: FontWeight.bold,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
            itemCount: 5,
          )
        ],
      ),
    );
  }
}
