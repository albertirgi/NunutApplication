import 'package:flutter/material.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:nunut_application/widgets/nunutTextFormField.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  //controller
  TextEditingController topUpController = TextEditingController();

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
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NunutText(title: "Nominal Top-Up", fontWeight: FontWeight.bold, size: 20),
                NunutTextFormField(
                  title: "",
                  hintText: "Minimal top-up : 10.000",
                  obsecureText: false,
                  controller: topUpController,
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NunutButton(
                      title: "Rp. 30.000",
                      textSize: 12,
                      onPressed: () {
                        setState(() {
                          topUpController.text = "30000";
                        });
                      },
                      widthButton: 90,
                      heightButton: 30,
                      borderColor: Colors.transparent,
                      fontWeight: FontWeight.bold,
                    ),
                    NunutButton(
                      title: "Rp. 50.000",
                      textSize: 12,
                      onPressed: () {
                        setState(() {
                          topUpController.text = "50000";
                        });
                      },
                      widthButton: 90,
                      heightButton: 30,
                      borderColor: Colors.transparent,
                      fontWeight: FontWeight.bold,
                    ),
                    NunutButton(
                      title: "Rp. 100.000",
                      textSize: 12,
                      onPressed: () {
                        setState(() {
                          topUpController.text = "100000";
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
                NunutText(title: "Pilih Metode Pembayaran", fontWeight: FontWeight.bold, size: 20),
                SizedBox(height: 20),
                NunutButton(
                  title: "E-Money",
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  widthButton: MediaQuery.of(context).size.width,
                  borderRadius: 12,
                  type: 3,
                  onPressedArrowButton: () {
                    print("TEST");
                  },
                  borderColor: Colors.grey[300],
                  elevation: 3,
                ),
                SizedBox(height: 20),
                NunutButton(
                  title: "ATM / Bank Transfer",
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  widthButton: MediaQuery.of(context).size.width,
                  borderRadius: 12,
                  type: 3,
                  onPressedArrowButton: () {
                    print("TEST");
                  },
                  borderColor: Colors.grey[300],
                  elevation: 3,
                ),
                SizedBox(height: 20),
                NunutButton(
                  title: "Direct Debit",
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  widthButton: MediaQuery.of(context).size.width,
                  borderRadius: 12,
                  type: 3,
                  onPressedArrowButton: () {
                    print("TEST");
                  },
                  borderColor: Colors.grey[300],
                  elevation: 3,
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: NunutButton(
                    title: "Lanjutkan",
                    fontWeight: FontWeight.w500,
                    onPressed: () {},
                    borderColor: Colors.transparent,
                    borderRadius: 12,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
