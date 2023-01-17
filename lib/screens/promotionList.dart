import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/models/mpromotion.dart';
import 'package:nunut_application/resources/promotionApi.dart';
import 'package:nunut_application/screens/promotionDetail.dart';
import 'package:nunut_application/widgets/couponCard.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';

import '../theme.dart';
import 'package:intl/intl.dart';

class PromotionList extends StatefulWidget {
  const PromotionList({super.key});

  @override
  State<PromotionList> createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  List<Promotion> promotionList = [];
  bool? promotionListLoading;

  @override
  void initState() {
    super.initState();
    initPromotionList();
  }

  initPromotionList() async {
    setState(() {
      promotionListLoading = true;
    });

    promotionList.clear();
    promotionList = await promotionApi.getPromotionList();

    setState(() {
      promotionListLoading = false;
    });
  }

  Widget promoTerbaru(String heading, String kodePromo) {
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
          NunutText(title: heading, size: 14, maxLines: 2),
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
                      hintStyle: TextStyle(
                        color: Colors.grey,
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
                  borderRadius: 8,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Container(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 24,
          //     vertical: 0,
          //   ),
          //   child: NunutText(title: "Promo Terbaru"),
          // ),
          // SizedBox(height: 24),
          // Container(
          //   height: 95,
          //   child: ListView.separated(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 24,
          //       vertical: 0,
          //     ),
          //     shrinkWrap: true,
          //     physics: BouncingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: promotionList.length,
          //     itemBuilder: (context, index) {
          //       return promoTerbaru("", promotionList[index].code!);
          //     },
          //     separatorBuilder: (context, index) {
          //       return SizedBox(width: 8);
          //     },
          //   ),
          // ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 0,
            ),
            child: NunutText(title: "Kuponku"),
          ),
          promotionListLoading!
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PromotionDetail(promotion: promotionList[index]),
                          ),
                        );
                      },
                      child: CouponCard(
                        imagePath: promotionList[index].image!,
                        date: NunutText(
                          title: promotionList[index].expiredAt!,
                          fontWeight: FontWeight.bold,
                        ),
                        minTransaction: NunutText(
                          title: NumberFormat.currency(
                            locale: 'id',
                            symbol: '',
                            decimalDigits: 0,
                          ).format(int.parse(promotionList[index].minimum!)),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8);
                  },
                  itemCount: promotionList.length,
                )
        ],
      ),
    );
  }
}
