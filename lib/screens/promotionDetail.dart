import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nunut_application/widgets/nunutButton.dart';

import '../widgets/couponCard.dart';
import '../widgets/nunutText.dart';

class PromotionDetail extends StatelessWidget {
  const PromotionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(
        //   color: Colors.black,
        // ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        toolbarHeight: 100,
        leading: Container(
          margin: EdgeInsets.only(top: 52),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          CouponCard(
            imagePath: "https://t3.ftcdn.net/jpg/03/54/26/10/360_F_354261018_RD5YEbufu7Yjck3SNiRC6yfJLZoxIegZ.jpg",
            date: NunutText(
              title: "28 Januari 2022",
              fontWeight: FontWeight.bold,
            ),
            minTransaction: NunutText(
              title: "Rp. 15.000",
              fontWeight: FontWeight.bold,
            ),
            useBorder: false,
          ),
          Container(
            margin: EdgeInsets.only(top: 12, left: 48),
            child: NunutText(title: "Syarat & Ketentuan", fontWeight: FontWeight.bold, size: 18),
          ),
          Container(
            margin: EdgeInsets.only(top: 4, left: 32, right: 36),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NunutText(title: (index + 1).toString() + ". ", size: 14),
                    SizedBox(width: index == 0 ? 8 : 4),
                    Expanded(
                      child: NunutText(
                        title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
              itemCount: 8,
              separatorBuilder: (context, index) {
                return SizedBox(height: 4);
              },
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(28),
              child: NunutButton(
                title: "Gunakan",
                backgroundColor: Colors.black,
                textColor: Colors.white,
                borderRadius: 8,
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
