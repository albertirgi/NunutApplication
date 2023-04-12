import 'package:flutter/material.dart';
import 'package:nunut_application/configuration.dart';
import 'package:nunut_application/models/mrideschedule.dart';
import 'package:nunut_application/theme.dart';
import 'package:nunut_application/widgets/nunutButton.dart';
import 'package:nunut_application/widgets/nunutText.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:nunut_application/functions.dart';

class BookingDetail extends StatelessWidget {
  final RideSchedule rideSchedule;
  const BookingDetail({super.key, required this.rideSchedule});

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

  Widget driverBookingDetailContent(String headingTitle, BuildContext context) {
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
                  title: rideSchedule.driver!.name!,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: InkWell(
                  onTap: () {
                    String number = rideSchedule.driver != null ? "+62" + rideSchedule.driver.phoneNumber! : "6282256640981";
                    openwhatsapp(context, number);
                  },
                  child: Icon(
                    Icons.chat_bubble_outline_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     padding: EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Colors.black,
              //     ),
              //     child: InkWell(
              //       onTap: () {},
              //       child: Icon(
              //         Icons.call_outlined,
              //         color: Colors.white,
              //         size: 20,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          NunutText(
            title: rideSchedule.vehicle!.transportationType! + " | " + rideSchedule.vehicle!.licensePlate!,
            color: Colors.grey[700],
            size: 14,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String rideScheduleId = "12345";
    if (rideSchedule.id!.length < 5) {
      rideScheduleId = "12345";
    } else {
      rideScheduleId = rideSchedule.id.toString().substring(rideSchedule.id!.length - 5);
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: NunutText(title: "Booking Nunut #" + rideScheduleId, fontWeight: FontWeight.bold),
        backgroundColor: nunutPrimaryColor,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(48),
          children: [
            bookingDetailContent("Penumpang", config.user.name),
            driverBookingDetailContent("Driver", context),
            bookingDetailContent("Tanggal", rideSchedule.date.toString()),
            bookingDetailContent("Jam Berangkat", rideSchedule.time.toString()),
            bookingDetailContent("Meeting Point", rideSchedule.meetingPoint!.name!),
            bookingDetailContent("Destination", rideSchedule.destination!.name!),
            bookingDetailContent("Harga", "IDR " + priceFormat(rideSchedule.price.toString())),
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
                            data: rideSchedule.rideRequestList!['ride_request_id'],
                            // embeddedImage: AssetImage("assets/icon.png"),
                            // embeddedImageStyle: QrEmbeddedImageStyle(
                            //   size: Size(75, 75),
                            // ),
                            size: 120,
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
                Navigator.pushNamed(context, '/pengaduanKendala', arguments: {'rideSchedule': rideSchedule});
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
