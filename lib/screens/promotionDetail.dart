import 'package:flutter/material.dart';
import 'package:nunut_application/models/mpromotion.dart';
import 'package:nunut_application/widgets/nunutButton.dart';

import '../widgets/couponCard.dart';
import '../widgets/nunutText.dart';

class PromotionDetail extends StatefulWidget {
  final Promotion? promotion;
  const PromotionDetail({super.key, this.promotion});

  @override
  State<PromotionDetail> createState() => _PromotionDetailState();
}

class _PromotionDetailState extends State<PromotionDetail> {
  @override
  void initState() {
    super.initState();
  }

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
            imagePath: widget.promotion!.image!,
            date: NunutText(title: widget.promotion!.expiredAt!, fontWeight: FontWeight.bold),
            minTransaction: NunutText(title: "Rp. " + widget.promotion!.minimum!, fontWeight: FontWeight.bold),
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
                        title: widget.promotion!.tnc![index],
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
              itemCount: widget.promotion!.tnc!.length,
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
