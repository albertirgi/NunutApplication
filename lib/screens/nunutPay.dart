import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:intl/intl.dart';

class NunutPay extends StatefulWidget {
  const NunutPay({super.key});

  @override
  State<NunutPay> createState() => _NunutPayState();
}

class _NunutPayState extends State<NunutPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/logoNoText.png",
                        width: 50,
                        height: 50,
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
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    decoration: BoxDecoration(
                      color: nunutPrimaryColor,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(5, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        NunutText(title: "TOTAL SALDO ANDA SAAT INI"),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            BorderedText(
                              child: Text(
                                "Rp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                ),
                              ),
                              strokeWidth: 3.0,
                              strokeColor: Colors.black,
                            ),
                            SizedBox(width: 5),
                            BorderedText(
                              child: Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: '',
                                  decimalDigits: 0,
                                ).format(350000),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 65,
                                ),
                              ),
                              strokeWidth: 3.0,
                              strokeColor: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NunutButton(
                          title: "Top up",
                          onPressed: () {
                            Navigator.pushNamed(context, '/topUp');
                          },
                          widthButton: 110,
                          textColor: Colors.white,
                          backgroundColor: Colors.black,
                          iconButton: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                          heightButton: 40,
                        ),
                        NunutButton(
                          title: "Withdraw",
                          onPressed: () {
                            Navigator.pushNamed(context, '/withdraw');
                          },
                          widthButton: 130,
                          iconButton: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20,
                          ),
                          heightButton: 40,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        NunutText(title: "Transaksi", size: 20, fontWeight: FontWeight.w500),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Icon(Icons.arrow_upward),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      NunutText(title: "Top Up", fontWeight: FontWeight.bold),
                                      NunutText(
                                        title: "via ShopeePay",
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      NunutText(title: "+ 50.000", fontWeight: FontWeight.bold),
                                      NunutText(title: "20 Desember 2022, 12:50", color: Colors.grey, size: 12),
                                    ],
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 30);
                            },
                            itemCount: 5)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
