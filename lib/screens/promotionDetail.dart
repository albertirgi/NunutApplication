import 'package:flutter/material.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/models/mpromotion.dart';
import 'package:nunut_application/widgets/nunutButton.dart';

import '../widgets/couponCard.dart';
import '../widgets/nunutText.dart';

class PromotionDetail extends StatefulWidget {
  const PromotionDetail({super.key});

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
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final isFromProfile = arguments["isFromProfile"] as bool?;
    final promotion = arguments["promotion"] as PromotionModel?;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image(
              image: AssetImage('assets/backgroundCircle/backgroundCircle4.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 32, left: 8),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                CouponCard(
                  title: "Diskon ${priceFormat(promotion!.discount.toString())} dengan minimal transaksi Rp. ${priceFormat(promotion.minimumPuchase.toString())}",
                  imagePath: promotion.image,
                  date: NunutText(title: promotion.expiredAt, fontWeight: FontWeight.bold),
                  minTransaction: NunutText(title: "Rp. " + priceFormat(promotion.minimumPuchase.toString()), fontWeight: FontWeight.bold),
                  useBorder: false,
                  isList: false,
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, left: 28, right: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NunutText(title: "Syarat & Ketentuan", fontWeight: FontWeight.bold, size: 18),
                      ListView.separated(
                        padding: EdgeInsets.only(top: 8),
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
                                  title: promotion.tnc[index],
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: promotion.tnc.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 4);
                        },
                      ),
                    ],
                  ),
                ),
                !isFromProfile!
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.all(28),
                          child: NunutButton(
                            title: "Gunakan",
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            borderRadius: 8,
                            onPressed: () {
                              Navigator.of(context).pop(
                                PopWithResults(
                                  fromPage: "/promotionDetail",
                                  toPage: "/payment",
                                  results: promotion,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
