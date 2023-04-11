import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mdriver.dart';
import 'package:nunut_application/resources/driverApi.dart';
import 'package:nunut_application/screens/rideShare.dart';
import 'package:nunut_application/widgets/customDialog.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:intl/intl.dart';
import '../functions.dart';
import '../models/mwallet.dart';
import '../resources/midtransApi.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String balance = "0";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   initSaldo();
    // });
  }

  FutureOr onGoBack(dynamic value) {
    isLoading = false;
    onRefresh();
  }

  ChooseBuildingAlertDialog(bool fromUKP) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: NunutText(title: "Pilih Gedung", size: 20, fontWeight: FontWeight.bold),
          content: CustomDialog(tempFromUKP: fromUKP),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                config.selectedBuilding = "";
                Navigator.pop(context);
              },
              child: NunutText(title: "Cancel", color: Colors.red),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RideShare(fromUKP: fromUKP),
                  ),
                ).then((value) => onGoBack(value));
              },
              child: NunutText(title: "OK", color: Colors.green),
            ),
          ],
        );
      },
    );
  }

  // void didchangeDependencies() {
  //   super.didChangeDependencies();
  //   initSaldo();
  // }

  // initSaldo() async {
  //   Wallet walletData = await MidtransApi.getWallet(config.user.id!);
  //   setState(() {
  //     double numValue = double.parse(walletData.balance.toString());
  //     NumberFormat currencyFormatter = NumberFormat.simpleCurrency(locale: "id", decimalDigits: 0, name: "");
  //     balance = currencyFormatter.format(numValue);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // MidtransApi.getWallet(config.user.id!).then((value) {
    //   setState(() {
    //     double numValue = double.parse(value.balance.toString());
    //     NumberFormat currencyFormatter = NumberFormat.simpleCurrency(
    //         locale: "id", decimalDigits: 0, name: "");
    //     balance = currencyFormatter.format(numValue);
    //   });
    // });
    return Scaffold(
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
              margin: EdgeInsets.only(top: 52, left: 28, right: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        Spacer(),

                        // SizedBox(width: 10),
                        Container(
                          width: 40,
                          height: 40,
                          // margin:
                          //     EdgeInsets.only(top: 62, bottom: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.bookmark, color: Colors.black),
                            onPressed: () {
                              Navigator.pushNamed(context, '/rideBookmark').then((value) => onGoBack(value));
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 40,
                          height: 40,
                          // margin:
                          //     EdgeInsets.only(top: 62, bottom: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.list, color: Colors.black, size: 18),
                            onPressed: () {
                              Navigator.pushNamed(context, '/orderList').then((value) => onGoBack(value));
                            },
                          ),
                        ),
                        //icon task
                        // Container(
                        //   width: 40,
                        //   height: 40,
                        //   // margin:
                        //   //     EdgeInsets.only(top: 62, bottom: 10, right: 20),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(24),
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 2,
                        //         blurRadius: 5,
                        //         offset:
                        //             Offset(0, 0), // changes position of shadow
                        //       ),
                        //     ],
                        //   ),
                        //   child: IconButton(
                        //     icon: Icon(Icons.menu, color: Colors.black),
                        //     onPressed: () {},
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  NunutText(title: "Hai, ${config.user.name}", fontWeight: FontWeight.bold),
                  SizedBox(height: 10),
                  NunutText(title: "Mau Nunut\nKemana Hari Ini?", isTitle: true, size: 32),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                child: Column(
                                  children: [
                                    Image.asset('assets/destination.png'),
                                    NunutText(title: "Dari", size: 8),
                                    NunutText(title: "Lokasi Jemput", size: 12, fontWeight: FontWeight.bold),
                                    NunutText(title: "Pergi Ke", size: 8),
                                    NunutText(title: "UK Petra", size: 12, fontWeight: FontWeight.bold),
                                  ],
                                ),
                                onTap: () {
                                  // ChooseBuildingAlertDialog(false);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RideShare(fromUKP: false),
                                    ),
                                  ).then((value) => onGoBack(value));
                                },
                              ),
                              Container(
                                width: 20,
                                child: Dash(
                                  direction: Axis.vertical,
                                  length: 100,
                                  dashLength: 5,
                                  dashColor: Colors.black,
                                ),
                              ),
                              InkWell(
                                child: Column(
                                  children: [
                                    Image.asset('assets/graduation.png'),
                                    NunutText(title: "Dari", size: 8),
                                    NunutText(title: "UK Petra", size: 12, fontWeight: FontWeight.bold),
                                    NunutText(title: "Pergi Ke", size: 8),
                                    NunutText(title: "Lokasi Tujuan", size: 12, fontWeight: FontWeight.bold),
                                  ],
                                ),
                                onTap: () {
                                  // ChooseBuildingAlertDialog(true);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RideShare(fromUKP: true),
                                    ),
                                  ).then((value) => onGoBack(value));
                                },
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: nunutPrimaryColor,
                              border: Border(
                                top: BorderSide(color: Colors.black, width: 2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Image.asset('assets/icon.png', width: 30, height: 30),
                                      SizedBox(width: 10),
                                      NunutText(title: "Saldo anda", fontWeight: FontWeight.bold, size: 12),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/nunutPay').then((value) => onGoBack(value));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: isLoading
                                        ? SpinKitThreeBounce(color: nunutPrimaryColor, size: 14)
                                        : Row(
                                            children: [
                                              NunutText(title: "Rp", fontWeight: FontWeight.bold, size: 8),
                                              SizedBox(width: 5),
                                              NunutText(title: config.user.wallet.toString(), fontWeight: FontWeight.bold, size: 12),
                                              SizedBox(width: 10),
                                              Icon(Icons.add, color: Colors.black, size: 12),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
                        image: AssetImage('assets/bgcontainer.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: NunutText(title: "Pelajari syaratnya", size: 12, color: Colors.white),
                              onTap: () {},
                            ),
                            Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white)
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NunutText(title: "Punya", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "kendaraan", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "Pribadi", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "Mau dapat pemasukkan tambahan?", color: Colors.white, size: 12),
                              SizedBox(height: 20),
                              NunutButton(
                                title: "Tawarkan Tumpangan",
                                onPressed: () {
                                  if (config.user.driverId == "empty") {
                                    Fluttertoast.showToast(
                                      msg: "Mohon mendaftar sebagai driver sebelum mengakses halaman ini",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    Navigator.of(context).pushNamed('/driverRegistration', arguments: config.user).then((value) => onGoBack(value));
                                  } else {
                                    DriverApi.getDriverById(config.user.driverId ?? "").then((value) {
                                      if (value.status.toLowerCase() == "pending") {
                                        Fluttertoast.showToast(
                                          msg: "Data sedang diproses oleh admin. mohon menunggu",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      } else if (value.status.toLowerCase() == "rejected") {
                                        Fluttertoast.showToast(
                                          msg: "Mohon maaf, permintaan anda ditolak, harap mengajukan permintaan kembali",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      } else if (value.status.toLowerCase() == "approved") {
                                        Navigator.of(context).pushNamed('/addRideSchedule', arguments: config.user).then((value) => onGoBack(value));
                                      }
                                    });
                                  }
                                },
                                textColor: Colors.black,
                                backgroundColor: nunutPrimaryColor,
                                fontWeight: FontWeight.bold,
                                heightButton: 40,
                                widthButton: 250,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(top: 100, left: 7, right: 7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
                        image: AssetImage('assets/bgcontainer2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NunutText(title: "Rame-rame", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "kendaraan", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                              NunutText(title: "Pribadi", color: Colors.white, size: 24, fontWeight: FontWeight.bold),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onRefresh() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    MidtransApi.getWallet(config.user.id!).then((value) {
      setState(() {
        config.user.wallet = priceFormat(value.balance!.toString());
      });
      return value;
    });
    setState(() {
      isLoading = false;
    });
  }
}
