import 'dart:async';
import 'dart:developer';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/functions.dart';
import 'package:nunut_application/models/mtransaction.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/authApi.dart';
import 'package:nunut_application/resources/midtransApi.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:intl/intl.dart';

import '../models/mwallet.dart';

class NunutPay extends StatefulWidget {
  const NunutPay({super.key});

  @override
  State<NunutPay> createState() => _NunutPayState();
}

class _NunutPayState extends State<NunutPay> {
  bool isLoading = true;
  bool userGenerated = false;
  Wallet wallet = Wallet();
  int walletBalance = 0;
  List<Transaction> transactions = [];
  int transactionLength = 0;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  FutureOr onGoBack(dynamic value) {
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.popAndPushNamed(context, '/main');
        return Future.value(false);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    color: nunutPrimaryColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_back, color: Colors.black, size: 22),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 5),
                            child: Row(
                              //baseline
                              // crossAxisAlignment: CrossAxisAlignment.baseline,
                              // textBaseline: TextBaseline.alphabetic,
                              children: [
                                Image.asset(
                                  "assets/logoNoText.png",
                                  width: 40,
                                  height: 40,
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
                                  offset: Offset(-1, -1), // changes position of shadow
                                ),
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(-1, 1), // changes position of shadow
                                ),
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(1, -1), // changes position of shadow
                                ),
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
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    NunutText(
                                      title: "Rp",
                                      isTitle: true,
                                      size: 24,
                                    ),
                                    SizedBox(width: 5),
                                    NunutText(
                                      title: config.user.wallet.toString(),
                                      isTitle: true,
                                      size: 65,
                                      maxLines: 1,
                                    )
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
                                  iconButton: Icon(Icons.remove, color: Colors.black, size: 20),
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
                                isLoading
                                    ? Container(
                                        padding: EdgeInsets.all(40),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(nunutPrimaryColor),
                                          ),
                                        ),
                                      )
                                    : transactionLength == 0
                                        ? Container(
                                            padding: EdgeInsets.all(40),
                                            child: Center(
                                              child: NunutText(
                                                title: "Tidak ada transaksi",
                                                color: Colors.grey,
                                                size: 16,
                                              ),
                                            ),
                                          )
                                        : ListView.separated(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              String status = transactions[index].status ?? "Pending";
                                              status = status[0].toUpperCase() + status.substring(1);
                                              return Row(
                                                children: [
                                                  Icon(Icons.arrow_upward),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      NunutText(title: transactions[index].type == "topup" ? "Top Up" : "Withdraw", fontWeight: FontWeight.bold),
                                                      NunutText(title: "Bank Transfer"),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      NunutText(
                                                        title: transactions[index].type == "topup"
                                                            ? "+ " + priceFormat(transactions[index].amount.toString()) + " ($status)"
                                                            : "- " + priceFormat(transactions[index].amount.toString()) + " ($status)",
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      NunutText(
                                                        title: DateFormat("d MMMM yyyy, hh:MM", "id_ID").format(transactions[index].transaction_time!), //"20 Desember 2022, 12:50",
                                                        color: Colors.grey,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 30);
                                            },
                                            itemCount: transactionLength,
                                          ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getUserInfo() async {
    getWallet(config.user.id!);
    setState(() {
      userGenerated = true;
    });
  }

  void getWallet(String user_id) async {
    MidtransApi.getWallet(user_id).then((value) {
      walletBalance = value.balance!;
      setState(() {
        config.user.wallet = priceFormat(walletBalance.toString());
      });
      getTransaction(value.id);
      return value;
    });
  }

  void getTransaction(String wallet_id) async {
    setState(() {
      isLoading = true;
    });
    transactions = await MidtransApi.getTransactionByWallet(wallet_id);
    setState(() {
      isLoading = false;
      transactionLength = transactions.length;
      transactions.sort((a, b) => b.transaction_time!.compareTo(a.transaction_time!));
    });
  }

  onRefresh() {
    getUserInfo();
  }
}
