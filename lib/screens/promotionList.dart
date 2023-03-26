import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/models/mpromotion.dart';
import 'package:nunut_application/resources/promotionApi.dart';
import 'package:nunut_application/screens/promotionDetail.dart';
import 'package:nunut_application/widgets/nunutText.dart';

import '../theme.dart';
import '../widgets/couponCard.dart';

class PromotionList extends StatefulWidget {
  const PromotionList({super.key});

  @override
  State<PromotionList> createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  List<PromotionModel> promotionList = [];
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
    promotionList = await promotionApi.getPromotionList(checkURL: true);

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
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final isFromProfile = arguments["isFromProfile"] as bool?;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/lingkaranKuning_2.png",
              width: MediaQuery.of(context).size.width * 0.815,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.085,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 18),
                  child: NunutText(title: "Kupon Promosi", size: 32, isTitle: true),
                ),
              ],
            ),
          ),
          promotionListLoading!
              ? Center(child: CircularProgressIndicator())
              : promotionList.isNotEmpty
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 0.22,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            initPromotionList();
                          },
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => PromotionDetail(promotion: promotionList[index]),
                                  //   ),
                                  // );
                                  Navigator.of(context).pushNamed('/promotionDetail', arguments: {'promotion': promotionList[index], 'isFromProfile': isFromProfile}).then((results) {
                                    if (results is PopWithResults) {
                                      PopWithResults popResult = results;
                                      if (popResult.toPage == "/promotionList") {
                                        // TODO do stuff
                                      } else {
                                        // pop to previous page
                                        Navigator.of(context).pop(results);
                                      }
                                    }
                                  });
                                },
                                child: CouponCard(
                                  title:
                                      "Diskon Rp. ${priceFormat(promotionList[index].maximumDiscount.toString())} dengan minimal transaksi Rp. ${priceFormat(promotionList[index].minimumPuchase.toString())}",
                                  imagePath: promotionList[index].image,
                                  date: NunutText(
                                    title: promotionList[index].expiredAt,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  minTransaction: NunutText(
                                    title: "Rp. " + priceFormat(promotionList[index].minimumPuchase.toString()),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 8);
                            },
                            itemCount: promotionList.length,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text("Voucher tidak tersedia"),
                    ),
        ],
      ),
    );
  }
}
