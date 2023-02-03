import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nunut_application/models/muser.dart';
import 'package:nunut_application/resources/authApi.dart';
import 'package:nunut_application/resources/midtransApi.dart';
import 'package:nunut_application/resources/walletApi.dart';
import 'package:nunut_application/screens/snap.dart';
import 'package:nunut_application/screens/topUpPayment.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutRadioButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import 'package:intl/intl.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  //controller
  TextEditingController topUpController = TextEditingController();
  String? _isPaymentSelected = "bca";
  bool isExpanded = false;
  bool isLoading = false;
  List<Widget> dropdownItems = [
    Row(
      children: [
        InkWell(
          child: ListTile(
            title: Text("Gopay"),
          ),
          onTap: () {},
        ),
        Icon(Icons.arrow_forward_ios, size: 15),
      ],
    ),
    Container(
      height: 0.3,
      color: Colors.grey,
      width: double.infinity,
    ),
    InkWell(
      child: ListTile(
        title: Text("OVO"),
      ),
      onTap: () {},
    ),
    Container(
      height: 0.3,
      color: Colors.grey,
      width: double.infinity,
    ),
    InkWell(
      child: ListTile(
        title: Text("DANA"),
      ),
      onTap: () {},
    ),
    Container(
      height: 0.3,
      color: Colors.grey,
      width: double.infinity,
    ),
  ];

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
                          "Top Up",
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
            // height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NunutText(
                    title: "Nominal Top-Up",
                    fontWeight: FontWeight.bold,
                    size: 20),
                NunutTextFormField(
                  title: "",
                  hintText: "Minimal top-up : 10.000",
                  obsecureText: false,
                  controller: topUpController,
                  keyboardType: TextInputType.number,
                  is_currency: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutButton(
                      title: "Rp. 30.000",
                      textSize: 12,
                      onPressed: () {
                        setState(() {
                          topUpController.text = "Rp. 30.000";
                        });
                      },
                      widthButton: 100,
                      heightButton: 30,
                      borderColor: Colors.transparent,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 10),
                    NunutButton(
                      title: "Rp. 50.000",
                      textSize: 12,
                      onPressed: () {
                        setState(() {
                          topUpController.text = "Rp. 50.000";
                        });
                      },
                      widthButton: 100,
                      heightButton: 30,
                      borderColor: Colors.transparent,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 10),
                    NunutButton(
                      title: "Rp. 100.000",
                      textSize: 12,
                      onPressed: () {
                        setState(() {
                          topUpController.text = "Rp. 100.000";
                        });
                      },
                      widthButton: 100,
                      heightButton: 30,
                      borderColor: Colors.transparent,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                NunutText(
                    title: "Pilih Metode Pembayaran",
                    fontWeight: FontWeight.bold,
                    size: 20),
                SizedBox(height: 20),
                // Theme(
                //   data: Theme.of(context).copyWith(
                //     dividerColor: Colors.transparent,
                //   ),
                //   child: ExpansionTile(
                //     title: NunutText(
                //       title: "E-Money",
                //       fontWeight: FontWeight.bold,
                //     ),
                //     children: [
                //       NunutRadioButton(
                //         label: "GO-PAY",
                //         groupValue: _isPaymentSelected,
                //         value: "GO-PAY",
                //         onChanged: (value) {
                //           setState(() {
                //             _isPaymentSelected = value;
                //           });
                //         },
                //       ),
                //       // NunutRadioButton(
                //       //   label: "OVO",
                //       //   groupValue: _isPaymentSelected,
                //       //   value: "OVO",
                //       //   onChanged: (value) {
                //       //     setState(() {
                //       //       _isPaymentSelected = value;
                //       //     });
                //       //   },
                //       // ),
                //       // NunutRadioButton(
                //       //   label: "Shopee Pay",
                //       //   groupValue: _isPaymentSelected,
                //       //   value: "Shopee Pay",
                //       //   onChanged: (value) {
                //       //     setState(() {
                //       //       _isPaymentSelected = value;
                //       //     });
                //       //   },
                //       // ),
                //       // NunutRadioButton(
                //       //   label: "LinkAja",
                //       //   groupValue: _isPaymentSelected,
                //       //   value: "LinkAja",
                //       //   onChanged: (value) {
                //       //     setState(() {
                //       //       _isPaymentSelected = value;
                //       //     });
                //       //   },
                //       // ),
                //     ],
                //     onExpansionChanged: (value) {
                //       setState(() {
                //         isExpanded = value;
                //       });
                //     },
                //   ),
                // ),
                !isExpanded ? Divider(height: 1) : Container(),
                SizedBox(height: 20),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: NunutText(
                      title: "ATM / Bank Transfer",
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      NunutRadioButton(
                        label: "BCA",
                        groupValue: _isPaymentSelected,
                        value: "bca",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                      NunutRadioButton(
                        label: "BNI",
                        groupValue: _isPaymentSelected,
                        value: "bni",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                      NunutRadioButton(
                        label: "BRI",
                        groupValue: _isPaymentSelected,
                        value: "bri",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                      NunutRadioButton(
                        label: "Mandiri",
                        groupValue: _isPaymentSelected,
                        value: "echannel",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                      NunutRadioButton(
                        label: "Permata",
                        groupValue: _isPaymentSelected,
                        value: "permata",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                      // NunutRadioButton(
                      //   label: "OVO",
                      //   groupValue: _isPaymentSelected,
                      //   value: "OVO",
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _isPaymentSelected = value;
                      //     });
                      //   },
                      // ),
                      // NunutRadioButton(
                      //   label: "Shopee Pay",
                      //   groupValue: _isPaymentSelected,
                      //   value: "Shopee Pay",
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _isPaymentSelected = value;
                      //     });
                      //   },
                      // ),
                      // NunutRadioButton(
                      //   label: "LinkAja",
                      //   groupValue: _isPaymentSelected,
                      //   value: "LinkAja",
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _isPaymentSelected = value;
                      //     });
                      //   },
                      // ),
                    ],
                    onExpansionChanged: (value) {
                      setState(() {
                        isExpanded = value;
                      });
                    },
                  ),
                ),
                // NunutButton(
                //   title: "ATM / Bank Transfer",
                //   onPressed: () {},
                //   backgroundColor: Colors.white,
                //   widthButton: MediaQuery.of(context).size.width,
                //   borderRadius: 12,
                //   type: 3,
                //   onPressedArrowButton: () {
                //     print("TEST");
                //   },
                //   borderColor: Colors.grey[300],
                //   elevation: 3,
                // ),
                // SizedBox(height: 20),
                // NunutButton(
                //   title: "Direct Debit",
                //   onPressed: () {},
                //   backgroundColor: Colors.white,
                //   widthButton: MediaQuery.of(context).size.width,
                //   borderRadius: 12,
                //   type: 3,
                //   onPressedArrowButton: () {
                //     print("TEST");
                //   },
                //   borderColor: Colors.grey[300],
                //   elevation: 3,
                // ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: nunutPrimaryColor,
                            strokeWidth: 2,
                          ),
                        )
                      : NunutButton(
                          title: "Lanjutkan",
                          fontWeight: FontWeight.w500,
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            var res = await topup();
                            if (res != null) {
                              setState(() {
                                isLoading = false;
                              });
                              if (res["status"] == 500 ||
                                  res["status"] == 400) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Transaction failed. Please try again later"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TopUpPayment(data: res),
                                ),
                              );
                            }
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

  topup() async {
    UserModel user = await AuthService.getCurrentUser();
    String payment_type = _isPaymentSelected!;
    String bank = _isPaymentSelected!;
    switch (_isPaymentSelected) {
      case "bca":
        payment_type = "bank_transfer";
        bank = "bca";
        break;
      case "bni":
        payment_type = "bank_transfer";
        bank = "bni";
        break;
      case "bri":
        payment_type = "bank_transfer";
        bank = "bri";
        break;
      case "echannel":
        payment_type = "echannel";
        bank = "mandiri";
        break;
      case "permata":
        payment_type = "permata";
        bank = "permata";
        break;
      default:
    }
    String amount = topUpController.text.replaceAll(RegExp(r'[A-Za-z\. ]'), "");
    return await MidtransApi.Topup(int.parse(amount), user.name, "", user.email,
        user.phone, user.id!, payment_type, bank);
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double numValue = double.parse(newValue.text);
    NumberFormat currencyFormatter = NumberFormat.simpleCurrency(
        locale: "id", decimalDigits: 0, name: "Rp. ");
    String newText = currencyFormatter.format(numValue);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
