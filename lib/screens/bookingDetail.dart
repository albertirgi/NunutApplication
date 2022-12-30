import 'package:flutter/material.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingDetail extends StatelessWidget {
  const BookingDetail({super.key});

  Widget bookingDetailContent(String headingTitle, String contentData) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NunutText(
            title: headingTitle.toUpperCase(),
            color: Colors.grey[700],
            size: 14,
          ),
          NunutText(
            title: contentData,
            size: 20,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget driverBookingDetailContent(String headingTitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NunutText(
            title: headingTitle.toUpperCase(),
            color: Colors.grey[700],
            size: 14,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: NunutText(
                  title: "Albert Wijaya",
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.chat_bubble_outline_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.call_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          NunutText(
            title: "Suzuki Ertiga | L 1598 EQ",
            color: Colors.grey[700],
            size: 14,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: NunutText(
            title: "Booking Nunut #1234", fontWeight: FontWeight.bold),
        backgroundColor: nunutPrimaryColor,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(48),
          children: [
            bookingDetailContent("Penumpang", "Grace Natasha"),
            driverBookingDetailContent("Driver"),
            bookingDetailContent("Tanggal", "Sabtu, 17-09-2022"),
            bookingDetailContent("Jam Berangkat", "10.00 WIB"),
            bookingDetailContent("Meeting Point", "Galaxy Mall 3"),
            bookingDetailContent("Harga", "IDR 15.000"),
            SizedBox(height: 32),
            NunutButton(
              title: "Lihat QR Code",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close),
                            ),
                          ),
                          QrImage(
                            data: "Grace Natasha",
                            embeddedImage: AssetImage("assets/icon.png"),
                            embeddedImageStyle: QrEmbeddedImageStyle(
                              size: Size(75, 75),
                            ),
                            size: 150,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.all(0),
                          ),
                          SizedBox(height: 16),
                          NunutText(
                            title: "Tunjukkan QR ke driver!",
                            size: 20,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              borderRadius: 8,
              widthBorder: 0,
              borderColor: Colors.transparent,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 16),
            NunutButton(
              title: "Ada Masalah?",
              fontWeight: FontWeight.bold,
              onPressed: () {
                Navigator.pushNamed(context, '/pengaduanKendala');
              },
              borderRadius: 8,
              widthBorder: 0,
              borderColor: Colors.transparent,
              backgroundColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
