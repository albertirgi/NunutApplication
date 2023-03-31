import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/models/mpromotion.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/models/mwallet.dart';
import 'package:nunut_application/resources/midtransApi.dart';
import 'package:nunut_application/resources/rideRequestApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:intl/intl.dart';
import 'package:nunut_application/widgets/popUpLoading.dart';

class Payment extends StatefulWidget {
  RideSchedule rideSchedule;
  Payment({super.key, required this.rideSchedule});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double biayaAdmin = 0;
  double pajak = 0;
  double total = 0;
  bool isWalletEnough = false;
  PromotionModel? selectedPromotion;
  bool useVoucher = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // biayaAdmin = widget.rideSchedule.biayaAdmin.toString();
    pajak = (10 / 100 * widget.rideSchedule.price!);
    total = widget.rideSchedule.price! + pajak;
    checkWalletEnough();
  }

  void checkWalletEnough() {
    setState(() {
      isWalletEnough = widget.rideSchedule.price! <= double.parse(config.user.wallet!.replaceAll(".", ""));
    });
  }

  FutureOr onGoBack(dynamic value) {
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: NunutBackground(
          listWidgetColumn: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 22),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 32),
              child: NunutText(
                title: "Pesanan telah terkonfirmasi!",
                fontWeight: FontWeight.bold,
                size: 32,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 32),
              child: NunutText(
                title: "Mohon selesaikan pembayaran Anda",
                fontWeight: FontWeight.w500,
                size: 14,
              ),
            ),
            SizedBox(height: 20),
          ],
          child: Container(
            margin: EdgeInsets.only(top: 32, left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NunutText(title: "Perjalanan Anda", fontWeight: FontWeight.bold, size: 22),
                SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Icon(Icons.circle, color: nunutPrimaryColor, size: 18),
                        ),
                        Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                        Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                        Icon(Icons.fiber_manual_record, color: Colors.grey, size: 8),
                        Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Icon(Icons.circle, color: nunutBlueColor, size: 18),
                        ),
                      ],
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40.0,
                          child: Center(
                            child: NunutText(title: widget.rideSchedule.meetingPoint!.name!),
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          height: 40.0,
                          margin: EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              NunutText(title: widget.rideSchedule.destination!.name!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 24),
                //   child: NunutText(title: "12.4km", fontWeight: FontWeight.bold, size: 18, color: Colors.grey[400]),
                // ),
                SizedBox(height: 50),
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.4),
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(height: 20),
                NunutText(title: "Detail Pembayaran", fontWeight: FontWeight.bold, size: 22),
                SizedBox(height: 20),
                Row(
                  children: [
                    NunutText(title: "Biaya Nunut", size: 14),
                    Spacer(),
                    NunutText(
                      title: priceFormat(widget.rideSchedule.price!.toString()),
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    NunutText(title: "Pajak (10%)", size: 14),
                    Spacer(),
                    NunutText(
                      title: priceFormat(pajak.toString()),
                      size: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                useVoucher
                    ? Row(
                        children: [
                          NunutText(title: "Diskon", size: 14, color: nunutPrimaryColor4),
                          Spacer(),
                          NunutText(title: "- " + priceFormat(selectedPromotion!.maximumDiscount.toString()), size: 14, fontWeight: FontWeight.bold, color: nunutPrimaryColor4),
                        ],
                      )
                    : Container(),
                SizedBox(height: 20),
                NunutButton(
                  title: useVoucher ? "Promo Berhasil Digunakan" : "Gunakan Promo",
                  onPressed: () {
                    // Navigator.pushNamed(context, '/promotionList');
                    Navigator.of(context).pushNamed('/promotionList', arguments: {'isFromProfile': false}).then((results) {
                      if (results is PopWithResults) {
                        PopWithResults popResult = results;
                        if (popResult.toPage == "/payment") {
                          setState(() {
                            useVoucher = true;
                            selectedPromotion = popResult.results;
                            total = total - selectedPromotion!.maximumDiscount;
                          });
                        } else {
                          // pop to previous page
                          Navigator.of(context).pop(results);
                        }
                      }
                    });
                  },
                  iconButton: useVoucher
                      ? Icon(
                          Icons.verified_outlined,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                  backgroundColor: Colors.white,
                  widthButton: 325,
                  borderRadius: 12,
                  type: 2,
                  onPressedArrowButton: () {},
                  borderColor: Colors.grey[300],
                  elevation: 0,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    NunutText(title: "Total Harga", fontWeight: FontWeight.bold, size: 14),
                    Spacer(),
                    NunutText(
                      title: priceFormat(total.toString()),
                      fontWeight: FontWeight.bold,
                      size: 22,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Image.asset(
                          "assets/logoNoText.png",
                          width: 25,
                          height: 25,
                        ),
                      ),
                      NunutText(title: "Saldo Anda", color: Colors.white, fontWeight: FontWeight.w500, size: 14),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/nunutPay');
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 4),
                          padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              NunutText(title: "IDR " + config.user.wallet.toString(), fontWeight: FontWeight.bold, size: 14),
                              SizedBox(width: 1),
                              Icon(Icons.add, color: Colors.black, size: 14),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                NunutButton(
                  title: isWalletEnough ? "Konfirmasi Pembayaran" : "Saldo Tidak Cukup",
                  backgroundColor: isWalletEnough ? nunutPrimaryColor : Colors.grey,
                  isDisabled: !isWalletEnough,
                  borderRadius: 10,
                  borderColor: Colors.transparent,
                  fontWeight: FontWeight.bold,
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return PopUpLoading(title: "Transaksi Sedang Diproses...", subtitle: "Harap Menunggu...");
                      },
                    );

                    bool result = await rideRequestApi.addRideRequest(
                        rideScheduleId: widget.rideSchedule.id.toString(), status_ride: "REGISTERED", user_id: config.user.id!, voucherId: useVoucher ? selectedPromotion!.voucherId : "");
                    if (result) {
                      Wallet walletData = await MidtransApi.getWallet(config.user.id!);
                      priceFormat(walletData.balance.toString());

                      Navigator.pushNamed(context, '/success', arguments: {
                        'title': "Pembayaran Berhasil!",
                        'description': "Pembayaran Anda Berhasil Dilakukan",
                        'afterBooking': true,
                      });
                    } else {
                      Navigator.pushNamed(context, '/success', arguments: {
                        'title': "Pembayaran Gagal!",
                        'description': "Pembayaran Anda Gagal Dilakukan",
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    checkWalletEnough();
    total = total;
    useVoucher = useVoucher;
  }
}
