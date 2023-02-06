import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:nunut_application/resources/midtransApi.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutRadioButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';
import 'dart:developer';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  //controller
  TextEditingController WithdrawController = TextEditingController();
  TextEditingController _accountTextEditingController = TextEditingController();
  TextEditingController _accountHolderNameTextEditingController =
      TextEditingController();
  String? _isPaymentSelected = "GoPay";
  bool isExpanded = false;
  final List<String> items = [
    'BCA',
    'BNI',
    'BRI',
    'Mandiri',
    'Permata',
  ];
  String selectedValue = 'BCA';
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
            // height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NunutText(
                    title: "Nominal Withdraw",
                    fontWeight: FontWeight.bold,
                    size: 20),
                NunutTextFormField(
                  title: "",
                  hintText: "Minimal withdraw : 10.000",
                  obsecureText: false,
                  controller: WithdrawController,
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NunutButton(
                      title: "Rp. 30.000",
                      textSize: 12,
                      onPressed: () {
                        setState(() {
                          WithdrawController.text = "Rp. 30.000";
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
                          WithdrawController.text = "Rp. 50.000";
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
                          WithdrawController.text = "Rp. 100.000";
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
                    title: "Rekening Tujuan",
                    fontWeight: FontWeight.bold,
                    size: 20),
                SizedBox(height: 20),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: NunutText(
                      title: "Bank Transfer",
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      NunutRadioButton(
                        label: "John Doe - BCA 1234567890",
                        groupValue: _isPaymentSelected,
                        value: "doebca",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                      NunutRadioButton(
                        label: "Jane - BNI 1234567890",
                        groupValue: _isPaymentSelected,
                        value: "janebni",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                      NunutRadioButton(
                        label: "Patrick - Mandiri 1234567890",
                        groupValue: _isPaymentSelected,
                        value: "patmandiri",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                      NunutRadioButton(
                        label: "Budi - BRI 1234567890",
                        groupValue: _isPaymentSelected,
                        value: "bribudi",
                        onChanged: (value) {
                          setState(() {
                            _isPaymentSelected = value;
                          });
                        },
                      ),
                    ],
                    onExpansionChanged: (value) {
                      setState(() {
                        isExpanded = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height,
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.55,
                              ),
                              height: MediaQuery.of(context).size.height * 0.55,
                              padding: EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      child: Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onTap: () => Navigator.pop(context),
                                      onVerticalDragUpdate: (details) {
                                        int sensitivity = 8;
                                        if (details.delta.dy > sensitivity) {
                                          // Down Swipe
                                        } else if (details.delta.dy <
                                            -sensitivity) {
                                          // Up Swipe
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  NunutText(
                                    title: "Tambah Rekening",
                                    color: Colors.black,
                                    size: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Flexible(
                                      //   child: Column(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.start,
                                      //     children: [
                                      //       NunutText(
                                      //         title: "Tipe Rekening",
                                      //         fontWeight: FontWeight.bold,
                                      //         size: 12,
                                      //       ),
                                      //       SizedBox(height: 10),
                                      //       DropdownButtonHideUnderline(
                                      //         child: DropdownButton2(
                                      //           isExpanded: true,
                                      //           items: items
                                      //               .map((item) =>
                                      //                   DropdownMenuItem<String>(
                                      //                     value: item,
                                      //                     child: NunutText(
                                      //                         title: item,
                                      //                         size: 14,
                                      //                         overflow:
                                      //                             TextOverflow
                                      //                                 .ellipsis),
                                      //                   ))
                                      //               .toList(),
                                      //           value: selectedValue,
                                      //           onChanged: (value) {
                                      //             setState(() {
                                      //               selectedValue =
                                      //                   value as String;
                                      //             });
                                      //           },
                                      //           icon: const Icon(
                                      //             Icons
                                      //                 .arrow_forward_ios_outlined,
                                      //           ),
                                      //           iconSize: 14,
                                      //           iconEnabledColor: Colors.black,
                                      //           iconDisabledColor: Colors.grey,
                                      //           buttonHeight: 35,
                                      //           buttonWidth: 170,
                                      //           buttonPadding:
                                      //               const EdgeInsets.only(
                                      //                   left: 14, right: 14),
                                      //           buttonDecoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(24),
                                      //             color: Colors.grey[300],
                                      //           ),
                                      //           itemHeight: 40,
                                      //           itemPadding:
                                      //               const EdgeInsets.only(
                                      //                   left: 14, right: 14),
                                      //           dropdownMaxHeight: 200,
                                      //           dropdownWidth: 200,
                                      //           dropdownPadding: null,
                                      //           dropdownDecoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(24),
                                      //             color: Colors.grey[300],
                                      //           ),
                                      //           dropdownElevation: 8,
                                      //           scrollbarRadius:
                                      //               const Radius.circular(40),
                                      //           scrollbarThickness: 6,
                                      //           scrollbarAlwaysShow: true,
                                      //           offset: const Offset(-20, 0),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // SizedBox(width: 20),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NunutText(
                                              title: "Nama Bank/Perusahaan",
                                              fontWeight: FontWeight.bold,
                                              size: 12,
                                            ),
                                            SizedBox(height: 10),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                isExpanded: true,
                                                items: items
                                                    .map((item) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: NunutText(
                                                              title: item,
                                                              size: 14,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ))
                                                    .toList(),
                                                value: selectedValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    setState(() {
                                                      selectedValue =
                                                          value as String;
                                                    });
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                ),
                                                iconSize: 14,
                                                iconEnabledColor: Colors.black,
                                                iconDisabledColor: Colors.grey,
                                                buttonHeight: 35,
                                                buttonPadding:
                                                    const EdgeInsets.only(
                                                        left: 14, right: 14),
                                                buttonDecoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  color: Colors.grey[300],
                                                ),
                                                itemHeight: 40,
                                                itemPadding:
                                                    const EdgeInsets.only(
                                                        left: 14, right: 14),
                                                dropdownMaxHeight: 200,
                                                dropdownWidth: 200,
                                                dropdownPadding: null,
                                                dropdownDecoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  color: Colors.grey[300],
                                                ),
                                                dropdownElevation: 8,
                                                scrollbarRadius:
                                                    const Radius.circular(40),
                                                scrollbarThickness: 6,
                                                scrollbarAlwaysShow: true,
                                                offset: const Offset(-20, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      NunutText(
                                        title: "Nomor Rekening",
                                        fontWeight: FontWeight.bold,
                                        size: 12,
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        controller:
                                            _accountTextEditingController,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        cursorColor: Colors.black,
                                        obscureText: false,
                                        // controller: _licensePlateController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          isDense: true,
                                          hintText: "e.g. L 1234 XX",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[300],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      NunutText(
                                        title: "Nama Pemilik Rekening",
                                        fontWeight: FontWeight.bold,
                                        size: 12,
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        controller:
                                            _accountHolderNameTextEditingController,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        cursorColor: Colors.black,
                                        obscureText: false,
                                        // controller: _licensePlateController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          isDense: true,
                                          hintText: "e.g. 11/2024",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[300],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: NunutButton(
                                      title: "Tambah",
                                      onPressed: () async {
                                        // var res = await MidtransApi.addAccount(
                                        //   accountNumber:
                                        //       _accountTextEditingController
                                        //           .text,
                                        //   accountHolderName:
                                        //       _accountHolderNameTextEditingController
                                        //           .text,
                                        //   bankName: selectedValue,
                                        // );
                                        // if (res['status'] == 'success') {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(
                                        //     SnackBar(
                                        //       content: Text(
                                        //           "Account added successfully"),
                                        //     ),
                                        //   );
                                        // } else {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(
                                        //     SnackBar(
                                        //       content: Text(
                                        //           "Error adding account. Please try again later"),
                                        //     ),
                                        //   );
                                        // }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Account added successfully"),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                      heightButton: 35,
                                      widthButton: 110,
                                      fontWeight: FontWeight.w500,
                                      widthBorder: 0.0,
                                      borderColor: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  child: NunutText(
                      title: "Tambah akun rekening baru",
                      size: 14,
                      textDecoration: TextDecoration.underline),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 20,
                      top: isExpanded
                          ? MediaQuery.of(context).size.height * 0.1
                          : MediaQuery.of(context).size.height * 0.35),
                  child: NunutButton(
                    title: "Lanjutkan",
                    fontWeight: FontWeight.w500,
                    onPressed: () {
                      Navigator.pushNamed(context, '/withdrawConfirmation');
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
