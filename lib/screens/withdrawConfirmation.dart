import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/resources/midtransApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:intl/intl.dart';

class WithdrawConfirmation extends StatefulWidget {
  const WithdrawConfirmation({super.key});

  @override
  State<WithdrawConfirmation> createState() => _WithdrawConfirmationState();
}

class _WithdrawConfirmationState extends State<WithdrawConfirmation> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    double _total = double.parse(args['amount'].replaceAll('.', '')) + 1000;
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
              margin: EdgeInsets.only(left: 20, bottom: 30),
              child: Row(
                children: [
                  Image.asset(
                    "assets/logoNoText.png",
                    width: 50,
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Withdraw",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "NunutPay",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NunutText(title: "Nominal Withdraw", fontWeight: FontWeight.bold, size: 20),
                Row(
                  children: [
                    NunutText(title: "Rp. ", fontWeight: FontWeight.bold, size: 20),
                    NunutText(title: args['amount'], fontWeight: FontWeight.bold, size: 32),
                  ],
                ),
                SizedBox(height: 30),
                NunutText(title: "Rekening Tujuan", fontWeight: FontWeight.bold, size: 20),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      NunutText(title: args['bank'] + " - " + args['account_number'], fontWeight: FontWeight.bold, size: 20),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                NunutText(title: "Jumlah", fontWeight: FontWeight.bold, size: 20),
                SizedBox(height: 20),
                Row(
                  children: [
                    NunutText(title: "Withdraw", fontWeight: FontWeight.bold, size: 14),
                    Spacer(),
                    NunutText(title: args['amount'], fontWeight: FontWeight.bold, size: 14),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    NunutText(title: "Potongan Biaya Admin", fontWeight: FontWeight.bold, size: 14, color: nunutPrimaryColor),
                    Spacer(),
                    NunutText(title: "1.000", fontWeight: FontWeight.bold, size: 14, color: nunutPrimaryColor),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    NunutText(title: "Total Saldo Terpotong", fontWeight: FontWeight.bold, size: 14),
                    Spacer(),
                    NunutText(title: "Rp. ", fontWeight: FontWeight.bold, size: 14),
                    NunutText(title: priceFormat(_total.toString()), fontWeight: FontWeight.bold, size: 18),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, top: MediaQuery.of(context).size.height * 0.3),
                  child: NunutButton(
                    title: "Ajukan Withdraw",
                    fontWeight: FontWeight.w500,
                    onPressed: () {
                      MidtransApi.storePayout(args["beneficiary"], _total.toInt()).then((value) {
                        if (value.status == 200) {
                          Fluttertoast.showToast(
                              msg: "Pengajuan withdraw berhasil",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Pengajuan withdraw gagal",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        Navigator.popUntil(context, ModalRoute.withName('/nunutPay'));
                      });
                    },
                    borderColor: Colors.transparent,
                    borderRadius: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
