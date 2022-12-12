import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutBackground.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: NunutBackground(
        listWidgetColumn: [
          Container(
            margin: EdgeInsets.only(top: 80, left: 32),
            child: NunutText(
              title: "Pesanan telah terkonfirmasi!",
              fontWeight: FontWeight.bold,
              size: 32,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, left: 32),
            child: Row(
              children: [
                NunutText(
                  title: "Selesaikan pembayaran dalam ",
                  fontWeight: FontWeight.w500,
                  size: 14,
                ),
                NunutText(
                  title: "01:59",
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
        child: Container(
          margin: EdgeInsets.only(top: 32, left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 32),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: nunutPrimaryColor,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          width: 50,
                          height: 50,
                          child: Center(
                            child: NunutText(title: "1", fontWeight: FontWeight.bold, size: 24),
                          ),
                        ),
                        SizedBox(height: 3),
                        NunutText(title: "Billing", size: 12, fontWeight: FontWeight.bold),
                      ],
                    ),
                    SizedBox(width: 3),
                    Container(
                      width: 35,
                      height: 2,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    SizedBox(width: 3),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                          width: 50,
                          height: 50,
                          child: Center(
                            child: NunutText(title: "2", fontWeight: FontWeight.bold, size: 24, color: Colors.grey[400]),
                          ),
                        ),
                        SizedBox(height: 3),
                        NunutText(title: "Pilih Metode", size: 12, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                      ],
                    ),
                    SizedBox(width: 3),
                    Container(
                      width: 35,
                      height: 2,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    SizedBox(width: 3),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                          width: 50,
                          height: 50,
                          child: Center(
                            child: NunutText(title: "3", size: 24, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                          ),
                        ),
                        SizedBox(height: 3),
                        NunutText(title: "Selesai!", size: 12, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
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
                        child: Icon(Icons.circle, color: nunutPrimaryColor, size: 18),
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
                          child: NunutText(title: "Galaxy Mall 3"),
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        height: 40.0,
                        margin: EdgeInsets.only(top: 4.0),
                        child: Row(
                          children: [
                            NunutText(title: "Universitas Kristen Petra"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 24),
                child: NunutText(title: "12.4km", fontWeight: FontWeight.bold, size: 18, color: Colors.grey[400]),
              ),
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
                  NunutText(title: "15.000", size: 14, fontWeight: FontWeight.bold),
                ],
              ),
              Row(
                children: [
                  NunutText(title: "Pajak (10%)", size: 14),
                  Spacer(),
                  NunutText(title: "1.500", size: 14, fontWeight: FontWeight.bold),
                ],
              ),
              Row(
                children: [
                  NunutText(title: "Biaya Admin", size: 14),
                  Spacer(),
                  NunutText(title: "1.000", size: 14, fontWeight: FontWeight.bold),
                ],
              ),
              Row(
                children: [
                  NunutText(title: "Diskon", size: 14, color: nunutPrimaryColor4),
                  Spacer(),
                  NunutText(title: "-2.500", size: 14, fontWeight: FontWeight.bold, color: nunutPrimaryColor4),
                ],
              ),
              SizedBox(height: 20),
              NunutButton(
                title: "Promo Berhasil Digunakan",
                onPressed: () {
                  Navigator.pushNamed(context, '/promotionList');
                },
                iconButton: Icon(
                  Icons.verified_outlined,
                  color: Colors.green,
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
                  NunutText(title: "IDR " + "17.500", fontWeight: FontWeight.bold, size: 22),
                ],
              ),
              SizedBox(height: 20),
              NunutButton(
                title: "Pilih Metode Pembayaran",
                borderRadius: 10,
                borderColor: Colors.transparent,
                fontWeight: FontWeight.bold,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
